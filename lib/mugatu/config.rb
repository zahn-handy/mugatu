module Mugatu
  class Config
    def initialize(root_path:, parsed_argv:, foreign_argv:, registry:)
      @root_path = root_path
      @parsed_argv = parsed_argv
      @foreign_argv = foreign_argv
      @registry = registry
      @dotfile_contents = YAML.load_file(File.join(root_path, ".mugatu.yml"))
    end

    attr_reader :root_path

    def requested_files
      @foreign_argv
    end

    def base_ref
      @dotfile_contents["git"]["base"]["ref"]
    end

    def current_ref
      "HEAD"
    end

    def linter_config
      @dotfile_contents["linters"]
    end

    def formatter
      found_formatter = @registry.formatters[@parsed_argv[:format]]

      if found_formatter
        found_formatter
      else
        Mugatu::Formatters::Pretty
      end
    end
  end
end
