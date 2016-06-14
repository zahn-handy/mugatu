module Mugatu
  module Formatters
    class Pretty
      def self.identifier
        :pretty
      end

      def initialize(additions:, files:, start_time:)
        @problems = []
        @files = files
      end

      def start
      end

      def done
        if @problems.any?
          puts @problems.map(&:to_s).join("\n\n")
          puts
        end

        puts "Searched #{@files.count} files. Found #{@problems.count} problems."
      end

      def found(problem)
        @problems.push(problem)
      end
    end
  end
end
