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

    class << self
      def setup(loglevel)
        @logger_class =
          if loglevel.nil? || loglevel == :none
            NullLogger
          else
            ::Logger
          end

        self.loglevel = loglevel
      end

      def instance
        @logger ||= @logger_class.new(STDERR)
      end

      def loglevel=(loglevel)
        return if loglevel == :none || loglevel.nil?

        loglevel = loglevel.to_s.upcase
        instance.level = ::Logger.const_get(loglevel)
      end

      def method_missing(*args)
        instance.send(*args)
      end

      def respond_to_missing?(method_name, include_private = false)
        instance.respond_to?(method_name, include_private) || super
      end
    end
  end
end
