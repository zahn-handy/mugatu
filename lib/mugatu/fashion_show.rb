module Mugatu
  class FashionShow
    def initialize(linters_config:, linters_registry:, root:)
      @linters_config   = linters_config
      @linters_registry = linters_registry
      @root             = root
    end

    def runways
      @linters_config.map do |name, value|
        matcher = Mugatu::Bucket.new(
          name: name,
          base: value["base"],
          excludes: value["excludes"],
          includes: value["includes"]
        )
        linter = Mugatu::RubocopRunner.new(root: @root)

        Mugatu::Runway.new(name: name, matcher: matcher, linter: linter)
      end
    end
  end
end
