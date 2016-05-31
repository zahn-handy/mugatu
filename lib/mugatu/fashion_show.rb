module Mugatu
  # TODO: This should be enumerable
  class FashionShow
    def initialize(linters_config:, linters_registry:, root:)
      @linters_config   = linters_config
      @linters_registry = linters_registry.map { |l| [l.name.to_s, l] }.to_h
      @root             = root
    end

    def runways
      @linters_config.map do |name, value|
        matcher = build_matcher(name, value)
        linter  = build_linter(value["linter"])

        Mugatu::Runway.new(name: name, matcher: matcher, linter: linter)
      end
    end

    private

    # TODO: Create null linter
    def build_linter(name)
      driver = @linters_registry[name]
      Mugatu::CenterForAnts.new(driver: driver, root: @root)
    end

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
