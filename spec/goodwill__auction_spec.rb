require 'goodwill/urlpaths'
require 'spec_helper'
require 'pry'

describe Goodwill::Auction do
  before do
    stub_request(:get, 'https://www.shopgoodwill.com/SignIn')
      .to_return(File.new('spec/fixtures/SignIn.html_get'))

    stub_request(:post, 'https://www.shopgoodwill.com/SignIn')
      .to_return(File.new('spec/fixtures/SignIn.html_post'))

    stub_request(:get, 'https://www.shopgoodwill.com/viewItem.asp?itemID=47947780')
      .to_return(File.new('spec/fixtures/47947780.html'))

    stub_request(:get, /CalculateShipping/)
      .to_return(File.new('spec/fixtures/47947780_shipping'))
  end

  let(:auction) { Goodwill::Auction.new(47_947_780) }

  describe '#initialize' do
    it 'should be able to report the number of bids' do
      bids = 0
      result = auction.bids
      expect(result.class).to eq(Integer)
      expect(result).to eq(bids)
    end

    it 'should be able to report the current price' do
      current = 7.99
      result = auction.current
      expect(result.class).to eq(Float)
      expect(result).to eq(current)
    end

    it 'should be able to report the end time' do
      time = DateTime.strptime('1/19/2018 3:06:26 PM Pacific Time', '%m/%d/%Y %l:%M:%S %p %Z')
      result = auction.end
      expect(result.class).to eq(DateTime)
      expect(result).to eq(time)
    end

    it 'should be able to report the href' do
      href = 'https://www.shopgoodwill.com/viewItem.asp?itemID=47947780'
      result = auction.href
      expect(result).to eq(href)
    end

    it 'should be able to report the item name' do
      item = "Clark's Black Leather Mid-Heel Shoe Size M"
      result = auction.item
      expect(result).to eq(item)
    end

    it 'should be able to report the itemid' do
      itemid = 47_947_780
      result = auction.itemid
      expect(result).to eq(itemid)
    end

    it 'should be able to report the seller' do
      seller = 'Goodwill Industries of the Inland Northwest'
      result = auction.seller
      expect(result).to eq(seller)
    end

    it 'should be able to report the shipping price' do
      shipping = 7.75
      result = auction.shipping
      expect(result.class).to eq(Float)
      expect(result).to eq(shipping)
    end
  end

  describe '#==' do
    it 'should be able to equate similar items' do
      result = auction
      expect(result).to eq(instance_double('Goodwill::Auction', itemid: 47_947_780))
    end
  end

  describe '#to_hash' do
    it 'should be able to transform an auction into a hash' do
      hash = {
        'zipcode' => '97222',
        'state' => 'OR',
        'country' => 'United States',
        'bids' => 0,
        'current' => 7.99,
        'end' => '2018-01-19T15:06:26-08:00',
        'href' => 'https://www.shopgoodwill.com/viewItem.asp?itemID=47947780',
        'item' => "Clark's Black Leather Mid-Heel Shoe Size M",
        'itemid' => 47_947_780,
        'seller' => 'Goodwill Industries of the Inland Northwest',
        'shipping' => 7.75,
        'bidding' => false
      }
      result = auction.to_hash
      expect(result).to eq(hash)
    end
  end
end
