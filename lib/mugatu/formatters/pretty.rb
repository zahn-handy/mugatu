module Mugatu
  module Formatters
    class Pretty
      def initialize
        @problems = []
      end

      def start(additions:, files:, start_time:)
      end

      def done
        puts @problems.map(&:to_s).join("\n\n")
      end

      def problem(problem)
        @problems.push(problem)
      end
    end
  end
end
