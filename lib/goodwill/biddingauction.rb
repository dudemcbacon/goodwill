require 'goodwill/urlpaths'

module Goodwill
  class BiddingAuction < Auction
    include URLPaths

    attr_reader :bidding
    attr_reader :winning
    attr_reader :max

    # TODO: why do i need this?
    attr_reader :bids
    attr_reader :current
    attr_reader :end
    attr_reader :href
    attr_reader :item
    attr_reader :itemid
    attr_reader :seller

    def initialize(itemid, mechanize)
      super(itemid)
      order_page = mechanize.get(OPEN_ORDERS_URL)
      if order_page.link_with(text: regqt(itemid.to_s))
        @bidding = true
        row = order_page.link_with(text: regqt(itemid.to_s)).node.parent.parent
        @winning = happy?(row.search('img').attr('src').value)
        @max = row.search('td:nth-child(5)').text
      else
        @bidding = false
        @winning = false
        @max = '$0.00'
      end
    end

    private

    def regqt(itemid)
      /#{Regexp.quote(itemid.to_s)}/
    end

    def happy?(src)
      src.include?('happy')
    end
  end
end
