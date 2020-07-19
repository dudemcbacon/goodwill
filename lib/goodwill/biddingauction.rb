# frozen_string_literal: true

require 'goodwill/urlpaths'

module Goodwill
  class BiddingAuction < Auction
    include URLPaths

    attr_reader :bidding, :winning, :max, :current, :end, :href, :item, :itemid, :seller, :shipping

    # TODO: why do i need this?
    attr_reader :bids

    def initialize(itemid, mechanize)
      super(itemid)
      order_page = mechanize.get(OPEN_ORDERS_URL)
      if order_page.link_with(text: regqt(itemid.to_s))
        @bidding = true
        row = order_page.link_with(text: regqt(itemid.to_s)).node.parent.parent
        @winning = !row.search('td:nth-child(5) > i').empty?
        @max = row.search('td:nth-child(5)').text.tr("\r\n", '').tr(' ', '').tr('$', '')
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
  end
end
