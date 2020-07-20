# frozen_string_literal: true

require 'thor'

module Goodwill
  class CLI < Thor
    class_option :verbose, type: :boolean
    class_option :username
    class_option :password
    class_option :threads

    def initialize(*args)
      super
      return if args[2][:current_command].name == 'help'

      username = options[:username] || ask('Username:')
      password = options[:password] || ask('Password:') { |q| q.echo = false }
      threads = options[:threads].to_i || 10
      @account = Goodwill::Account.new(username, password, threads)
    end

    desc 'auctions', "List all auctions you're currently bidding on"
    def auctions
      say "Your current auctions:\n"
      res = @account.in_progress
      if res.empty?
        puts 'No items found.'
      else
        tp res
      end
    end

    desc 'search SEARCH', 'Search for auctions matching SEARCH'
    def search(search)
      say 'Your search results:'
      res = @account.search(search)
      if res.empty?
        puts 'No items found.'
      else
        tp res
      end
    end

    desc 'bid ITEMID MAXBID', 'Bid MAXBID on ITEMID'
    def bid(itemid, maxbid)
      @accounts.bid(itemid, maxbid)
    end
  end
end
