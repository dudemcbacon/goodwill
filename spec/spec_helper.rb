# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'webmock/rspec'
require 'bundler/setup'
require 'goodwill'
require 'pry'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    match_requests_on: [:method,
                        VCR.request_matchers.uri_without_param(:_)]
  }
end

RSpec.configure { |c|; }
