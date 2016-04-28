module Mugatu
  module Drivers
    module RubocopDriver
      class Parser
        def initialize
          @linter = :rubocop
        end

        def call(errors)
          errors["files"].flat_map do |errors|
            parse_many_offenses(errors["path"], errors["offenses"])
          end
        end

        def parse_many_offenses(file, offenses)
          offenses.map do |offense|
            parse_offense(file, offense)
          end
        end

        def parse_offense(file, offense)
          Mugatu::Problem.new(
            linter:   @linter,
            name:     offense["cop_name"],
            message:  offense["message"],
            severity: offense["severity"],
            file:     file,
            line:     offense["location"]["line"],
            range:    (0..-1),
          )
        end
      end
    end
  end
end