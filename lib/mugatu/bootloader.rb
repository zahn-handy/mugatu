module Mugatu
  class Bootloader
    def initialize(root_path:, registry:)
      @registry    = registry
      @root_path   = root_path
      @config_path = File.join(root_path, ".mugatu.yml")
      @config      = YAML.load_file(@config_path)
    end

    attr_reader :root_path
    attr_reader :registry, :config_path, :config

    def processor_builder
      Mugatu::ProcessorBuilder.new(
        linters_config: @config["linters"],
        linters_registry: @registry,
        root: @root_path
      )
    end
  end
end
