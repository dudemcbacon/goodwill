require 'spec_helper'
require 'pry'

describe Goodwill::Auction do

  before do
    mech = Mechanize.new
    sample = mech.get('file:///' + File.expand_path('./spec/fixtures/sample_auction.html'))
    shipping = mech.get('file:///' + File.expand_path('./spec/fixtures/sample_auction_shipping.html'))
    mock = double("mechanize")
    params = "?itemid=25508822&zip=97222&state=OR&country=United States"
    allow(mock).to receive(:get).with(ITEM_SEARCH_URL + '25508822').and_return(sample)
    allow(mock).to receive(:get).with(SHIPPING_URL + params).and_return(shipping)
    expect_any_instance_of(Goodwill::Auction).to receive(:mechanize).twice.and_return(mock)
  end

  let(:auction) { Goodwill::Auction.new(25508822) }

  describe '#initialize' do

    it "should be able to report the number of bids" do
      bids = 10
      result = auction.bids
      expect(result.class).to eq(Fixnum)
      expect(result).to eq(bids)
    end

    it "should be able to report the current price" do
      current = 411.0
      result = auction.current
      expect(result.class).to eq(Float)
      expect(result).to eq(current)
    end

    it "should be able to report the end time" do
      time = DateTime.strptime("2015-11-08T17:43:53+00:00")
      result = auction.end
      expect(result.class).to eq(DateTime)
      expect(result).to eq(time)
    end

    it "should be able to report the href" do
      href = 'http://www.shopgoodwill.com/viewItem.asp?itemID=25508822'
      result = auction.href
      expect(result).to eq(href)
    end

    it "should be able to report the item name" do
      item = 'New 18K White Gold Emerald & Diamond Ring  (DL)'
      result = auction.item
      expect(result).to eq(item)
    end

    it "should be able to report the itemid" do
      itemid = 25508822
      result = auction.itemid
      expect(result).to eq(itemid)
    end

    it "should be able to report the seller" do
      seller = 'Licking/Knox Goodwill Industries, Inc.'
      result = auction.seller
      expect(result).to eq(seller)
    end

    it "should be able to report the shipping price" do
      shipping = 30.63
      result = auction.shipping
      expect(result.class).to eq(Float)
      expect(result).to eq(shipping)
    end
  end

  describe '#==' do
    it "should be able to equate similar items" do
      result = auction
      expect(result).to eq(instance_double("Goodwill::Auction", :itemid => 25508822))
    end
  end

  describe '#to_hash' do
    it "should be able to transform an auction into a hash" do
      hash = {
        "itemid"=>25508822,
        "zipcode"=>"97222",
        "state"=>"OR",
        "country"=>"United States",
        "href"=>"http://www.shopgoodwill.com/viewItem.asp?itemID=25508822",
        "bids"=>10,
        "current"=>411.0,
        "end"=>"2015-11-08T17:43:53+00:00",
        "item"=>"New 18K White Gold Emerald & Diamond Ring  (DL)",
        "seller"=>"Licking/Knox Goodwill Industries, Inc.",
        "bidding"=>false,
        "shipping"=>30.63
      }
      result = auction.to_hash
      expect(result).to eq(hash)
    end
  end
end
