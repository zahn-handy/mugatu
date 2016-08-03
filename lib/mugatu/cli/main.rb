module Mugatu
  module Cli
    class Main
      def initialize(runtime)
        start_time = Time.now
        @runtime = runtime
        @bootloader = runtime.bootloader
        @application = @bootloader.application
        @additions_hash = runtime.additions

        @formatter = runtime.formatter.new(
          additions: @additions_hash,
          files: runtime.files,
          start_time: start_time
        )
      end

      def call
        p @runtime.options
        p @bootloader.config
        result = pipe(
          Mugatu::Pipes::Diff.new(base: @bootloader.config["git"]["base"]["ref"], compare: "HEAD"),
          Mugatu::Pipes::DiffParser.new,
        )

        p result
        # problems = @application.lint(@runtime.files)
        #
        # printable_problems =
        #   problems.select do |problem|
        #     contexts = @additions_hash[problem.file]
        #
        #     if contexts.nil?
        #       Mugatu::Zipdisk.debug("No context for file `#{problem.file}` - assuming new file")
        #       true
        #     else
        #       problem_within_diff =
        #         contexts.any? do |context|
        #           context.lines.include?(problem.line)
        #         end
        #
        #       if problem_within_diff
        #         Mugatu::Zipdisk.debug("Problem within diff: #{problem.inspect}")
        #       else
        #         Mugatu::Zipdisk.debug("Problem outside diff: #{problem.inspect}")
        #       end
        #
        #       problem_within_diff
        #     end
        #   end
        #
        # @formatter.start
        # printable_problems.each { |p| @formatter.found(p) }
        # @formatter.done
      end

      def pipe(*blockishes)
        blockishes.flatten.each_with_object({}) do |blockish, memo|
          blockish.call(memo)
        end
      end
    end
  end
end
