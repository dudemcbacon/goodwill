require 'spec_helper'
require 'pry'

IN_PROG = 'https://www.shopgoodwill.com/buyers/myShop/AuctionsInProgress.asp'.freeze

include Goodwill::URLPaths

describe Goodwill::Account do
  before do
    stub_request(:get, 'https://www.shopgoodwill.com/SignIn')
      .to_return(File.new('spec/fixtures/SignIn.html_get'))

    stub_request(:post, 'https://www.shopgoodwill.com/SignIn')
      .to_return(File.new('spec/fixtures/SignIn.html_post'))
  end

  describe '#bid' do
    before do
      @account = Goodwill::Account.new('pants', 'pantspass')
    end

    it 'should be able to bid on auctions'
  end

  describe '#in_progress' do
    before do
      stub_request(:get, 'https://www.shopgoodwill.com/MyShopgoodwill/AuctionsInProgress')
        .to_return(File.new('spec/fixtures/in_progress_page'))

      %w[48294656 48120725 48112189].each do |itemid|
        stub_request(:get, "https://www.shopgoodwill.com/viewItem.asp?itemID=#{itemid}")
          .to_return(File.new("spec/fixtures/#{itemid}"))

        stub_request(:get, /CalculateShipping\?Country=United%20States&ItemId=#{Regexp.quote(itemid)}&State=OR&ZipCode=97222/)
          .to_return(File.new("spec/fixtures/#{itemid}_shipping"))
      end
    end

    it 'should be able to get a list of auctions in progress' do
      auctions = YAML.safe_load(File.open('./spec/fixtures/auctions.yaml'))

      @account = Goodwill::Account.new('foo', 'bar')
      result = @account.in_progress
      expect(result).to eq(auctions)
    end
  end

  describe '#search' do
    before do
      stub_request(:get, /Listings/)
        .to_return(File.new('spec/fixtures/search_page'))

      %w[48213986 48155521 48084603].each do |itemid|
        stub_request(:get, "https://www.shopgoodwill.com/viewItem.asp?itemID=#{itemid}")
          .to_return(File.new("spec/fixtures/#{itemid}"))

        stub_request(:get, /CalculateShipping\?Country=United%20States&ItemId=#{Regexp.quote(itemid)}&State=OR&ZipCode=97222/)
          .to_return(File.new("spec/fixtures/#{itemid}_shipping"))
      end
    end

    it 'should be able to search for auctions' do
      auctions = YAML.safe_load(File.open('./spec/fixtures/google_search_results.yaml'))

      @account = Goodwill::Account.new('foo', 'bar')
      result = @account.search('google home')
      expect(result).to eq(auctions)
    end
  end
end
