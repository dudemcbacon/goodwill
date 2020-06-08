# frozen_string_literal: true

require 'logger'

module Goodwill
  module Logging
    def logger
      Logging.logger
    end

    class << self
      def level
        @level ||= Logger::WARN
      end

      attr_writer :level

      def logger
        @logger ||= Logger.new(STDOUT)
        @logger.level = level
        @logger
      end
    end
  end
end
