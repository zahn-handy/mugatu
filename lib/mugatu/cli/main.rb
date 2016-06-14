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
        problems = @application.lint(@runtime.files)

        printable_problems =
          problems.select do |problem|
            contexts = @additions_hash[problem.file]

            if contexts.nil?
              true
            else
              contexts.any? do |context|
                context.lines.include?(problem.line)
              end
            end
          end

        @formatter.start
        printable_problems.each { |p| @formatter.found(p) }
        @formatter.done
      end
    end
  end
end
