module Mugatu
  module Cli
    class Main
      def initialize(runtime)
        bootloader = runtime.bootloader
        start_time = Time.now
        additions_hash = runtime.additions.group_by(&:filename)

        application = bootloader.application

        problems = application.lint(runtime.files)

        printable_problems =
          problems.select do |problem|
            contexts = additions_hash[problem.file]

            if contexts.nil?
              true
            else
              contexts.any? do |context|
                context.lines.include?(problem.line)
              end
            end
          end

        formatter = runtime.formatter.new(
          additions: additions_hash,
          files: runtime.files,
          start_time: start_time
        )
        formatter.start
        printable_problems.each { |p| formatter.found(p) }
        formatter.done
      end
    end
  end
end