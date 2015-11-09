require 'spec_helper'
require 'pry'

IN_PROG = 'https://www.shopgoodwill.com/buyers/myShop/AuctionsInProgress.asp'

include Goodwill::URLPaths

describe Goodwill::Account do

  before do
    mech = Mechanize.new
    @account = Goodwill::Account.new('brandonburnett', 'butthat1')
    in_prog_cont = mech.get('file:///' + File.expand_path('./spec/fixtures/in_progress.html'))
    allow(@account.mechanize).to receive(:get).with(IN_PROG).and_return(in_prog_cont)
    [ '24710437', '24763462', '24765885', '24766011'].each do |itemid|
      content = mech.get('file:///' + File.expand_path("./spec/fixtures/#{itemid}.html"))
      shipping = mech.get('file:///' + File.expand_path("./spec/fixtures/#{itemid}.html"))
      params = "?itemid=#{itemid}&zip=97222&state=OR&country=United States"
      allow(@account.mechanize).to receive(:get).with(ITEM_SEARCH_URL + itemid).and_return(content)
      allow(@account.mechanize).to receive(:get).with(SHIPPING_URL + params).and_return(shipping)
    end
  end

  describe '#bid' do
    it "should be able to bid on auctions"
  end

  describe '#in_progress' do
    it "should be able to get a list of auctions in progress" do
      auctions = YAML.load(File.open('./spec/fixtures/auctions.yaml'))
      expect(@account.in_progress).to eq(auctions)
    end
  end

  describe '#search' do
    it "should be able to search for auctions"
  end

end
