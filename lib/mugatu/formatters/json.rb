module Mugatu
  module Formatters
    class Json
      def self.identifier
        :json
      end

      class ProblemPresenter
        def initialize(problem)
          @problem = problem
        end

        def to_json(state = nil)
          as_json =
            {
              linter: @problem.linter,
              name: @problem.name,
              message: @problem.message,
              severity: @problem.severity,
              file: @problem.file,
              line: @problem.line,
              line_begin: @problem.range.first,
              line_end: @problem.range.last
            }

          as_json.to_json(state)
        end
      end

      def initialize(files:, start_time:)
        @problems = []
        @files = files
        @start_time = start_time
      end

      def start
      end

      def done
        end_time = Time.now
        problems = @problems.map { |problem| ProblemPresenter.new(problem) }

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
