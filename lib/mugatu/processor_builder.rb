module Mugatu
  # TODO: This should be enumerable
  class ProcessorBuilder
    def initialize(linters_config:, linters_registry:, root:)
      @linters_config   = linters_config
      @linters_registry = linters_registry.map { |l| [l.name.to_s, l] }.to_h
      @root             = root
    end

    def runways(files)
      @linters_config.map do |name, value|
        driver = @linters_registry[value["linter"]]
        matcher = build_matcher(name, value)

        Mugatu::Processor.new(
          driver: driver,
          matcher: matcher,
          root: @root,
          files: files
        )
      end
    end

    private

    def build_matcher(name, config)
      Mugatu::Matcher.new(
        name: name,
        base: config["base"],
        excludes: config["excludes"],
        includes: config["includes"]
      )
    end
  end
end
