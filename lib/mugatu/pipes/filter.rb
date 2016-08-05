module Mugatu
  module Pipes
    class Filter
      def call(additions:, problems:, **)
        additions_hash = additions.group_by(&:filename)

        problems.select do |problem|
          contexts = additions_hash[problem.file]

          if contexts.nil?
            Mugatu::Zipdisk.debug("No context for file `#{problem.file}` - assuming new file")
            true
          else
            problem_within_diff =
              contexts.any? do |context|
                context.lines.include?(problem.line)
              end

            if problem_within_diff
              Mugatu::Zipdisk.debug("Problem within diff: #{problem.inspect}")
            else
              Mugatu::Zipdisk.debug("Problem outside diff: #{problem.inspect}")
            end

            problem_within_diff
          end
        end
      end
    end
  end
end
