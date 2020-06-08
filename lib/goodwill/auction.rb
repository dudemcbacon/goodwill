# frozen_string_literal: true

require 'mechanize'

require 'goodwill/csspaths'
require 'goodwill/urlpaths'
require 'goodwill/mechanize'

module Goodwill
  #
  # A ShopGoodwill Auction
  #
  class Auction
    include Goodwill::Mechanize
    include CSSPaths
    include URLPaths

    attr_reader :item_page

    attr_reader :bids
    attr_reader :current
    attr_reader :end
    attr_reader :href
    attr_reader :item
    attr_reader :itemid
    attr_reader :seller
    attr_reader :shipping
    attr_reader :type

    def initialize(itemid, zipcode = '97222', state = 'OR', country = 'US')
      @itemid = itemid
      @zipcode = zipcode
      @state = state
      @country = country

      @href = ITEM_SEARCH_URL + itemid.to_s
      @item_page = mechanize.get(@href)

      @type = parse_type
      @bids = item_page.search(BIDS_PATH).text[/\d+/].to_i
      @current = item_page.search(CURRENT_PRICE_PATH).text.tr('$', '').to_f
      @end = parse_end_time
      @item = item_page.search(ITEM_TITLE_PATH).text
      @seller = item_page.search(SELLER_PATH).text
      @bidding = false
      @shipping = calculate_shipping(@itemid, @zipcode, @country)
    end

    def ==(other)
      itemid == other.itemid
    end

    def to_hash
      hash = {}
      instance_variables.each do |var|
        next if var == :@item_page

        hash[var.to_s.delete('@')] = if var == :@end
                                       instance_variable_get(var).to_s
                                     else
                                       instance_variable_get(var)
                                     end
      end
      hash
    end

    private

    def calculate_shipping(itemid, zipcode, country)
      params = "?ZipCode=#{zipcode}&Country=#{country}&ItemId=#{itemid}&Quantity=1&_=#{DateTime.now.strftime('%s')}"
      page = mechanize.get(SHIPPING_URL + params)
      page.search(SHIPPING_PATH).text.split(': ').last.tr('$', '').to_f
    end

    def parse_end_time
      search_path = type == :auction ? END_TIME_PATH : BIN_END_TIME_PATH
      time = item_page.search(search_path).text.split(': ')[1]
      return nil if time.nil?

      DateTime.strptime(time, '%m/%d/%Y %l:%M:%S %p %Z')
    rescue Date::Error
      nil
    end

    def parse_type
      item_page.search(BUY_IT_NOW_PATH).empty? ? :auction : :buyitnow
    end
  end
end
