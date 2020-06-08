# frozen_string_literal: true

require 'goodwill/urlpaths'
require 'spec_helper'

describe Goodwill::Auction do
  let(:auction) { Goodwill::Auction.new(94_811_058) }

  describe '#initialize' do
    it 'should be able to report the number of bids', :vcr do
      bids = 9
      result = auction.bids
      expect(result).to eq(bids)
    end

    it 'should be able to report the current price', :vcr do
      current = 112.51
      result = auction.current
      expect(result.class).to eq(Float)
      expect(result).to eq(current)
    end

    it 'should be able to report the end time', :vcr do
      time = DateTime.strptime('6/12/2020 8:03:00 PM Pacific Time', '%m/%d/%Y %l:%M:%S %p %Z')
      result = auction.end
      expect(result.class).to eq(DateTime)
      expect(result).to eq(time)
    end

    it 'should be able to report the href', :vcr do
      href = 'https://www.shopgoodwill.com/viewItem.asp?itemID=94811058'
      result = auction.href
      expect(result).to eq(href)
    end

    it 'should be able to report the item name', :vcr do
      item = 'Starrett Gage Amplifier & Gaging Head 715'
      result = auction.item
      expect(result).to eq(item)
    end

    it 'should be able to report the itemid', :vcr do
      itemid = 94_811_058
      result = auction.itemid
      expect(result).to eq(itemid)
    end

    it 'should be able to report the seller', :vcr do
      seller = 'Goodwill Retail Services, Inc.'
      result = auction.seller
      expect(result).to eq(seller)
    end

    it 'should be able to report the shipping price', :vcr do
      shipping = 9.56
      result = auction.shipping
      expect(result.class).to eq(Float)
      expect(result).to eq(shipping)
    end
  end

  describe '#==' do
    it 'should be able to equate similar items', :vcr do
      result = auction
      expect(result).to eq(instance_double('Goodwill::Auction', itemid: 94_811_058))
    end
  end

  describe '#to_hash' do
    it 'should be able to transform an auction into a hash', :vcr do
      hash = {
        'zipcode' => '97222',
        'state' => 'OR',
        'country' => 'US',
        'bids' => 9,
        'current' => 112.51,
        'end' => '2020-06-12T20:03:00-08:00',
        'href' => 'https://www.shopgoodwill.com/viewItem.asp?itemID=94811058',
        'item' => 'Starrett Gage Amplifier & Gaging Head 715',
        'itemid' => 94_811_058,
        'seller' => 'Goodwill Retail Services, Inc.',
        'shipping' => 9.56,
        'bidding' => false,
        'type' => :auction
      }
      result = auction.to_hash
      expect(result).to eq(hash)
    end
  end
end
