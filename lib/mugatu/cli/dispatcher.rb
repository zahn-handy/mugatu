module Mugatu
  module Cli
    class Dispatcher
      def self.start(options, paths)
        instance = new(options)
        instance.lint(*paths)
      end

      def initialize(options)
        @options = options
      end

      attr_reader :options

      def lint(*paths)
        Commands::Lint.new(bootloader, paths, options)
      end

      private

      def bootloader
        Mugatu::Bootloader.new(root_path: current_working_directory, registry: registry)
      end

      def current_working_directory
        File.expand_path("")
      end

      def registry
        [
          Mugatu::Drivers::RubocopDriver
        ]
      end
    end
  end
end
