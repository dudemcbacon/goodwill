# frozen_string_literal: true

require 'goodwill/auction'
require 'goodwill/mechanize'
require 'goodwill/urlpaths'
require 'goodwill/csspaths'

require 'json'
require 'mechanize'
require 'parallel'

module Goodwill
  #
  # Allows for basic account interaction
  #
  class Account
    include Goodwill::Mechanize
    include URLPaths
    include CSSPaths

    PER_PAGE = 25

    attr_reader :username, :password, :threads

    def initialize(username, password = '', threads = 10)
      @username  = username
      @password  = password
      @threads   = threads
      Goodwill::Mechanize.username = @username
      Goodwill::Mechanize.password = @password
    end

    def in_progress
      in_progress_page = mechanize.get(OPEN_ORDERS_URL)
      Parallel.map(in_progress_page.search(IN_PROGRESS_ROWS), in_threads: @threads) do |row|
        Goodwill::BiddingAuction.new(itemid_from_open_order_row(row), mechanize)
      end
    end

    def search(item_title)
      search_page = mechanize.get(SEARCH_URL + item_title)
      Array.new(pages(total_items(search_page))) do |i|
        search_page = search_page.link_with(text: '>').click unless i.zero?
        Parallel.map(search_page.search(SEARCH_ROWS), in_threads: @threads) do |row|
          Goodwill::Auction.new(itemid_from_search_row(row))
        end
      end.flatten
    end

    def bid(itemid, bid)
      item = mechanize.get(ITEM_SEARCH_URL + itemid.to_s)
      href = item.search(SELLER_ID_LINK).attribute('href').value
      seller_id = href.split('/').last

      params = {
        itemId: itemid,
        bidAmount: bid,
        quantity: 1,
        sellerId: seller_id
      }

      # bidresult
      # 1 - success (check message for 'Bid Received!')
      # 1 - outbid (check message for 'You have already been outbid.')
      # -5 - bid less than minimum
      mechanize.get(BID_URL, params) do |page|
        res = JSON.parse(page.body)
        case res['BidResult']
        when 1
          return true if res['BidResultMessage'].include?('Bid Received')

          return false if res['BidResultMessage'].include?('You have already been outbid.')

          raise Goodwill::BidError, res['BidResultMessage']
        when -5
          raise Goodwill::BidError, res['BidResultMessage']
        end
      end
    end

    private

    def buyer_token
      mechanize.cookies.select { |c| c.name == 'AuthenticatedBuyerToken' }.first.value
    end

    def itemid_from_open_order_row(row)
      row.search('a').text
    end

    def itemid_from_search_row(row)
      row.search('a').first.attributes['href'].value.split('/').last
    end

    def pages(items)
      (items / 40.to_f).ceil
    end

    def request_token
      mechanize.cookies.select { |c| c.name == '__RequestVerificationToken' }.first.value
    end

    def total_items(page)
      page.search('//*[@id="search-results"]/div/div[1]/nav[1]/p').first.text.split(' of ')[1].split(' ').first.to_i
    end
  end
end
