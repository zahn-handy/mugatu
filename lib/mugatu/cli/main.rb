module Mugatu
  module Cli
    class Main
      def initialize(runtime)
        start_time = Time.now
        @runtime = runtime
        @bootloader = runtime.bootloader
        @application = @bootloader.application

        @formatter = runtime.formatter.new(
          files: runtime.files,
          start_time: start_time
        )
      end

      def call
        pp @runtime
        pp @bootloader.config
        result = pipe(
          branch_point: Mugatu::Pipes::BranchPoint.new,
          files: Mugatu::Pipes::Files.new(@runtime.requested_files, @bootloader.root_path),
          diff: Mugatu::Pipes::Diff.new(base: @bootloader.config["git"]["base"]["ref"], compare: "HEAD"),
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
