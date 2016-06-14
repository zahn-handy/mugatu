module Mugatu
  module Cli
    class Dispatcher
      def self.start(registry, paths, options)
        instance = new(registry, paths, options)
        instance.lint
      end

      def initialize(registry, paths, options)
        @registry = registry
        @paths = paths
        @options = options
      end

      attr_reader :options

      def lint
        main = Main.new(runtime)
        main.call
      end

      private

      def bootloader
        @bootloader ||=
          Mugatu::Bootloader.new(
            root_path: current_working_directory,
            registry: @registry.linters
          )
      end

      def runtime
        Mugatu::Runtime.new(
          bootloader: bootloader,
          requested_files: @paths,
          ref: options[:ref],
          options: options
        )
      end

      def current_working_directory
        File.expand_path("")
      end
    end
  end
end
