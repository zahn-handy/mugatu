module Mugatu
  # TODO: This should be enumerable
  class ProcessorBuilder
    def initialize(linters_config:, linters_registry:, root:)
      @linters_config   = linters_config
      @linters_registry = linters_registry
      @root             = root
    end

    def processors(files)
      @linters_config.map do |name, config|
        linter_name = config["linter"].to_sym
        driver = @linters_registry[linter_name]
        matcher = build_matcher(name, config)

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
