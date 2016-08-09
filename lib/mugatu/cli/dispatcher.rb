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
          registry: @registry
        )

        main = Main.new(config, @registry)
        main.call
      end

      private

      def current_working_directory
        File.expand_path("")
      end
    end
  end
end
