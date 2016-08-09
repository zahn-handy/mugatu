module Mugatu
  module Cli
    class Dispatcher
      def self.start(registry, options)
        instance = new(registry, options)
        instance.lint
      end

      def initialize(registry, options)
        @registry = registry
        @options = options
      end

      attr_reader :options

      def lint
        config = Mugatu::Config.new(
          root_path: current_working_directory,
          parsed_argv: @options.options,
          foreign_argv: @options.files,
          dotfile_contents: YAML.load_file(File.join(current_working_directory, ".mugatu.yml"))
        )

        main = Main.new(formatter, config, @registry)
        main.call
      end

      private

      def current_working_directory
        File.expand_path("")
      end

      def formatter
        found_formatter = @registry.formatters[@options.options[:format]]

        if found_formatter
          found_formatter
        else
          Mugatu::Formatters::Pretty
        end
      end
    end
  end
end
