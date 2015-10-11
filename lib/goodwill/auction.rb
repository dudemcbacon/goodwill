require 'mechanize'

require 'goodwill/csspaths'
require 'goodwill/urlpaths'
require 'goodwill/mechanize'

module Goodwill
  class Auction
    include Goodwill::Mechanize
    include CSSPaths
    include URLPaths

    attr_reader :bids
    attr_reader :current
    attr_reader :end
    attr_reader :href
    attr_reader :item
    attr_reader :itemid
    attr_reader :seller

    def initialize(itemid = nil)
      @href = ITEM_SEARCH_URL + itemid.to_s
      @itemid = itemid
      item_page = mechanize.get(@href)
      @bids = item_page.search(BIDS_PATH).text[/\d+/]
      @current = item_page.search(CURRENT_PRICE_PATH).text
      @end = item_page.search(END_TIME_PATH).text
      @item = item_page.search(ITEM_TITLE_PATH).text
      @seller = item_page.search(SELLER_PATH).text
      @bidding = false
    end

    def ==(another_auction)
      self.itemid == another_auction.itemid
    end
  end
end
