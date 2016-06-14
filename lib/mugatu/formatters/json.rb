module Mugatu
  module Formatters
    class Json
      def self.identifier
        :json
      end

      def initialize(additions:, files:, start_time:)
        @problems = []
        @files = files
        @additions = additions
        @start_time = start_time
      end

      def start
      end

      def done
        end_time = Time.now
        problems = @problems.map { |problem| problem }

        result = {
          summary: {
            elapsed_time: end_time - @start_time
          },
          searched_files: @files.each.to_a,
          problems: problems
        }

        puts JSON.generate(result)
      end

      def found(problem)
        @problems.push(problem)
      end
    end
  end
end
