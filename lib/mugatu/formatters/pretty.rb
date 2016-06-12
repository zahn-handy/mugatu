module Mugatu
  module Formatters
    class Pretty
      def initialize(additions:, files:, start_time:)
        @problems = []
        @files = files
      end

      def start
      end

      def done
        puts @problems.map(&:to_s).join("\n\n")
        puts
        puts "Searched #{@files.count} files. Found #{@problems.count} problems."
      end

      def found(problem)
        @problems.push(problem)
      end
    end
  end
end
