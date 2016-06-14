require_relative "rubocop_driver/parser"
require_relative "rubocop_driver/runner"

module Mugatu
  module Drivers
    module RubocopDriver
      def self.identifier
        :rubocop
      end
    end
  end
end
