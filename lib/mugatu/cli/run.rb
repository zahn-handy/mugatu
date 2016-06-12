module Mugatu
  module Cli
    class Options
    end

    class Run
      def self.parse(args)
        @options = ScriptOptions.new
        parser.parse!(args)
        @options
      end

      def initialize
      end
    end
  end
end
