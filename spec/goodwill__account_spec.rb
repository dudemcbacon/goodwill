# frozen_string_literal: true

require 'spec_helper'

describe Goodwill::Account, :vcr do
  let(:account) { Goodwill::Account.new('foo', 'foo') }

  describe '#bid' do
    it 'should be able to bid on auctions'
  end

  describe '#in_progress' do
    it 'should be able to get a list of auctions in progress' do
      result = account.in_progress
      expect(result.length).to eq(3)
      expect(result.map(&:item)).to eq(['4 Macbook Pro 13" Laptops A1278 PARTS REPAIR',
                                        'Kenwood R-5000 Communications Reciever',
                                        '3 Working Amazon Kindle Fires'])
      expect(result.map(&:itemid)).to eq(%w[94624392 94629344 94634162])
    end
  end

  describe '#search' do
    it 'should be able to search for auctions' do
      result = account.search('starrett')
      expect(result.length).to eq(5)
      expect(result.map(&:item)).to eq(['10 Assorted Metal Engineering Tools B.S. Starrett',
                                        'Starrett Metal Precision Gage Block Set',
                                        'Starrett Dial Test Indicator',
                                        'Starrett Machinist Dial Caliper Micrometer in Box',
                                        'Starrett Gage Amplifier & Gaging Head 715'])
      expect(result.map(&:itemid)).to eq(%w[94482102 94545401 94570343 94651589 94811058])
    end
  end
end
