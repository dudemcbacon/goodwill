[![Gem Version](https://badge.fury.io/rb/goodwill.svg)](https://badge.fury.io/rb/goodwill)
[![Build Status](https://travis-ci.org/dudemcbacon/goodwill.svg?branch=master)](https://travis-ci.org/dudemcbacon/goodwill)
[![Code Climate](https://codeclimate.com/github/dudemcbacon/goodwill/badges/gpa.svg)](https://codeclimate.com/github/dudemcbacon/goodwill)
[![Inline docs](http://inch-ci.org/github/dudemcbacon/goodwill.svg?branch=master)](http://inch-ci.org/github/dudemcbacon/goodwill)
# Goodwill

Goodwill is a simple web scraper for ShopGoodwill.com. You can query login to your account, view your currently in progress auction, search for items, and even bid on new options. It also includes a small CLI for interacting with ShopGoodwill.com from the command-line.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'goodwill'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install goodwill

## Usage

```ruby
gem 'goodwill'

account = Goodwill::Account.new('username', 'password')

pp account.search('famicom')
[#<Goodwill::Auction:0x007fbf50ec0c18
  @bidding=false,
  @bids="8",
  @current="$66.00",
  @end="",
  @href="http://www.shopgoodwill.com/viewItem.asp?itemID=25576979",
  @item="Two Nintendo Super Famicom Game Consoles 020",
  @itemid="25576979",
  @seller="Columbia Goodwill">]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dudemcbacon/goodwill.
