module Mugatu
  module Cli
    class Main
      def initialize(config, registry)
        start_time = Time.now
        @config = config
        @registry = registry

        @formatter = config.formatter.new(
          start_time: start_time
        )
      end

      def call
        result = pipe(
          branch_point: Mugatu::Pipes::BranchPoint.new,
          processor_builder: Mugatu::Pipes::InitProcessors.new(@config, @registry),
          files: Mugatu::Pipes::Files.new(@config.requested_files, @config.root_path),
          diff: Mugatu::Pipes::Diff.new(base: @config.base_ref, compare: @config.current_ref),
          additions: Mugatu::Pipes::DiffParser.new,
          problems: Mugatu::Pipes::Linter.new,
          personal_problems: Mugatu::Pipes::Filter.new
        )

        @formatter.start
        result[:personal_problems].each { |p| @formatter.found(p) }
        @formatter.done(result[:files])
      end

      def pipe(blockishes)
        blockishes.each_with_object({}) do |(key, blockish), memo|
          memo[key] = blockish.call(memo)
        end
      end
    end
  end
end
