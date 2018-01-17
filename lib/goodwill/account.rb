require 'goodwill/auction'
require 'goodwill/mechanize'
require 'goodwill/urlpaths'

require 'mechanize'
require 'parallel'

module Goodwill
  #
  # Allows for basic account interaction
  #
  class Account
    include Goodwill::Mechanize
    include URLPaths

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
      Parallel.map(in_progress_page.search('#my-auctions-table > tbody > tr'), in_threads: @threads) do |row|
        Goodwill::BiddingAuction.new(itemid_from_open_order_row(row), mechanize)
      end
    end

    def search(item_title)
      search_page = mechanize.get(SEARCH_URL + item_title)
      pages(total_items(search_page)).times.map do |i|
        search_page = search_page.link_with(text: '>').click unless i == 0
        Parallel.map(search_page.search('#search-results > div > section > ul.products > li'), in_threads: @threads) do |row|
          Goodwill::Auction.new(itemid_from_search_row(row))
        end
      end.flatten
    end

    def bid(itemid, bid)
      mechanize.get(ITEM_SEARCH_URL + itemid.to_s) do |page|
        form = page.form_with(action: 'https://www.shopgoodwill.com/reviewBidrcs.asp')
        form.maxbid = bid.to_f
        confirmation_page = form.submit
        confirmation_form = confirmation_page.form_with(action: 'https://www.shopgoodwill.com/reviewBidrcs.asp?state=2&puconf=Y')
        confirmation_form.buyerLogin = @username
        confirmation_form.buyerPasswd = @password
        butt = confirmation_form.submit
        butt.search('tr')[1].text.split.last.tr('$', '') == bid ? true : false
      end
    end

    private

    def pages(items)
      (items / 40.to_f).ceil
    end

    def total_items(page)
      page.search('//*[@id="search-results"]/div/div[1]/nav[1]/p').first.text.split(" of ")[1].split(" ").first.to_i
    end

    def itemid_from_open_order_row(row)
      row.search('a').text
    end

    def itemid_from_search_row(row)
      row.search('a').first.attributes["href"].value.split('/').last
    end
  end
end
