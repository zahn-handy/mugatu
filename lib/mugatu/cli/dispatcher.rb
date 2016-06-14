module Mugatu
  module Cli
    class Dispatcher
      def self.start(options, paths, registry)
        instance = new(options, registry)
        instance.lint(*paths)
      end

      def initialize(options, registry)
        @options = options
        @registry = registry
      end

      attr_reader :options

      def lint(*paths)
        main = Main.new(runtime(paths))
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

      def runtime(requested_files)
        Mugatu::Runtime.new(
          bootloader: bootloader,
          requested_files: requested_files,
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
