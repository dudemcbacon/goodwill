# frozen_string_literal: true

require 'mechanize'

require 'goodwill/urlpaths'

module Goodwill
  module Mechanize
    def mechanize
      Mechanize.mechanize
    end

    class << self
      include URLPaths

      def username
        @username ||= nil
      end

      attr_writer :username

      def password
        @password ||= nil
      end

      attr_writer :password

      def logged_in?
        @logged_in ||= false
      end

      def mechanize
        @mechanize ||= ::Mechanize.new
        login
        @mechanize
      end

      def login
        return true if logged_in?

        @mechanize.get(LOGIN_URL) do |page|
          my_page = page.form_with(action: '/SignIn') do |f|
            f.Username = @username
            f.Password = @password
          end.click_button
          @logged_in = my_page.links.map(&:to_s).include? 'My Shopgoodwill '
        end
      end
    end
  end
end
