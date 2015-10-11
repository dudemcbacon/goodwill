require 'goodwill/auction'
require 'goodwill/mechanize'
require 'goodwill/urlpaths'

require 'mechanize'

module Goodwill
  class Account
    include Goodwill::Mechanize
    include URLPaths

    IN_PROG = 'https://www.shopgoodwill.com/buyers/myShop/AuctionsInProgress.asp'
    PER_PAGE = 25

    attr_reader :username, :password

    def initialize(username, password = '')
      @username  = username
      @password  = password
      Goodwill::Mechanize.username = @username
      Goodwill::Mechanize.password = @password
    end

    def in_progress
      in_progress_page = mechanize.get(IN_PROG)
      in_progress_page.search('table.mySG tbody tr').map do |row|
        Goodwill::BiddingAuction.new(itemid_from_open_order_row(row), mechanize)
      end
    end

    def search(itemTitle)
      search_page = mechanize.get(SEARCH_URL + itemTitle)
      pages(total_items(search_page)).times.map do |i|
        search_page = search_page.link_with(text: 'Next').click unless i == 0
        search_page.search('table.productresults tbody > tr').map do |row|
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
      (items / 25.to_f).ceil
    end

    def total_items(page)
      page.search('div h1').text.split.first.to_i
    end

    def itemid_from_open_order_row(row)
      row.search('a').attr('href').value.split('=')[1]
    end

    def itemid_from_search_row(row)
      row.search('th:nth-child(1)').text
    end
  end
end
