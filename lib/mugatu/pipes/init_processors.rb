module Mugatu
  module Pipes
    class InitProcessors
      def initialize(config, registry)
        @config = config
        @registry = registry
      end

      def call(*)
        Mugatu::ProcessorBuilder.new(
          linters_config: @config.linter_config,
          linters_registry: @registry.linters,
          root: @config.root_path
        )
      end
    end
  end
end
