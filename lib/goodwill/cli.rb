# frozen_string_literal: true

require 'thor'

module Goodwill
  class CLI < Thor
    class_option :verbose, type: :boolean
    class_option :username
    class_option :password

    def initialize(*args)
      super
      return if args[2][:current_command].name == 'help'

      username = options[:username] || ask('Username:')
      password = options[:password] || ask('Password:') { |q| q.echo = false }
      @account = Goodwill::Account.new(username, password)
    end

    desc 'auctions', "List all auctions you're currently bidding on"
    def auctions
      say "Your current auctions:\n"
      tp @account.in_progress
    end

    desc 'search SEARCH', 'Search for auctions matching SEARCH'
    def search(search)
      say 'Your search results:'
      tp @account.search(search)
    end

    desc 'bid ITEMID MAXBID', 'Bid MAXBID on ITEMID'
    def bid(itemid, maxbid)
      @accounts.bid(itemid, maxbid)
    end
  end
end
