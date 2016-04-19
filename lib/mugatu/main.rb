module Mugatu
  class Main
    def initialize(root_path, registry, config)
      @root_path = root_path
      @config    = config
      @registry  = registry

      @linters =
        @config["linters"].map do |key, value|
          name         = key.to_sym
          linter_id    = value["linter"].to_sym
          linter_class = @registry.linters[linter_id]

          [name, linter_class]
        end.to_h

      @matchers =
        @config["linters"].map do |key, value|
          name = key.to_sym

          bucket =
            Bucket.new(
              name: name,
              base: value["base"] || [],
              excludes: value["excludes"] || [],
              includes: value["includes"] || []
            )

          [name, bucket]
        end.to_h

      @runways =
        @linters.map do |name, linter|
          runway = Runway.new(matcher: @matchers[name], linter: linter)

          [name, runway]
        end.to_h
    end
  end
end
