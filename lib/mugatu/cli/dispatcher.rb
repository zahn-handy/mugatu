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

        Mugatu::Zipdisk.info(@registry)
        Mugatu::Zipdisk.info("Files requested to run on: #{@paths.inspect}")
        Mugatu::Zipdisk.info("Options: #{@options.inspect}")
        Mugatu::Zipdisk.info("Files to run on: #{runtime.files.to_a.inspect}")
        Mugatu::Zipdisk.info("Diff additions: #{runtime.additions.inspect}")
        Mugatu::Zipdisk.info("Ref: #{runtime.ref}")
        Mugatu::Zipdisk.info("Formatter: #{runtime.formatter.inspect}")
      end

      attr_reader :options

      def lint
        r = runtime
        config = Mugatu::Config.new(
          root_path: bootloader.root_path,
          parsed_argv: @options,
          foreign_argv: r.requested_files,
          dotfile_contents: bootloader.config
        )

        main = Main.new(r, config, @registry)
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
