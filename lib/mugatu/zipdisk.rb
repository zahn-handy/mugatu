require "logger"

module Mugatu
  class Zipdisk
    class NullLogger
      def initialize(*)
      end

      def method_missing(*)
      end

      def respond_to_missing?(*)
        true
      end
    end

    class Internal
      def initialize(loglevel)
        @loglevel = loglevel
      end

      def logger
        if @logger
          return @logger
        end

        @logger = logger_class.new(STDERR)
        @logger.level = loglevel_const
        @logger
      end

      private

      def loglevel_const
        if @loglevel == :none || @loglevel.nil?
          return ::Logger::FATAL
        end

        @loglevel.to_s.upcase
        ::Logger.const_get(@loglevel.to_s.upcase)
      end

      def logger_class
        if @loglevel.nil? || @loglevel == :none
          NullLogger
        else
          ::Logger
        end
      end
    end

    class << self
      def setup(loglevel)
        @instance = Internal.new(loglevel)
      end

      def logger
        if @logger
          return @logger
        end

        if @instance
          @logger = @instance.logger
          return @logger
        end

        @default_instance ||= Internal.new(nil)
        @default_instance.logger
      end

      def method_missing(*args)
        logger.send(*args)
      end

      def respond_to_missing?(method_name, include_private = false)
        logger.respond_to?(method_name, include_private) || super
      end
    end
  end
end
