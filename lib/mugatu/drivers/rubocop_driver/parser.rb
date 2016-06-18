module Mugatu
  module Drivers
    module RubocopDriver
      class Parser
        def initialize
          @linter = :rubocop
        end

        def call(errors)
          errors["files"].flat_map do |errors_on_file|
            parse_many_offenses(errors_on_file["path"], errors_on_file["offenses"])
          end
        end

        def parse_many_offenses(file, offenses)
          offenses.map do |offense|
            parse_offense(file, offense)
          end
        end

        def parse_offense(file, offense)
          problem_start = offense["location"]["column"]
          problem_end = problem_start + offense["location"]["length"] - 1

          Mugatu::Problem.new(
            linter:   @linter,
            name:     offense["cop_name"],
            message:  offense["message"],
            severity: offense["severity"],
            file:     file,
            line:     offense["location"]["line"],
            range:    (problem_start..problem_end)
          )
        end
      end
    end
  end
end
