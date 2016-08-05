module Mugatu
  module Cli
    class Main
      def initialize(runtime, config)
        start_time = Time.now
        @config = config
        @application = runtime.bootloader.application

        @formatter = runtime.formatter.new(
          files: runtime.files,
          start_time: start_time
        )
      end

      def call
        result = pipe(
          branch_point: Mugatu::Pipes::BranchPoint.new,
          files: Mugatu::Pipes::Files.new(@config.requested_files, @config.root_path),
          diff: Mugatu::Pipes::Diff.new(base: @config.base_ref, compare: @config.current_ref),
          additions: Mugatu::Pipes::DiffParser.new,
          problems: Mugatu::Pipes::Linter.new(@application),
          personal_problems: Mugatu::Pipes::Filter.new
        )

        pp result

        @formatter.start
        result[:personal_problems].each { |p| @formatter.found(p) }
        @formatter.done
      end

      def pipe(blockishes)
        blockishes.each_with_object({}) do |(key, blockish), memo|
          memo[key] = blockish.call(memo)
        end
      end
    end
  end
end
