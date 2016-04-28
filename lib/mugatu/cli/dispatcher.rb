module Mugatu
  module Cli
    class Dispatcher < Thor
      include Thor::Actions

      desc "lint", "Run linters"
      method_option :ref, desc: "Root for diff"
      def lint(*paths)
        Commands::Lint.new(bootloader, paths, options)
      end

      desc "init PATH", "Create an example .mugatu.yml at PATH"
      def init(path)
        puts "not yet implemented"
        puts "example:"
        puts File.read(File.expand_path("../../../.mugatu.yml", File.dirname(__FILE__)))
      end

      desc "version", "Print version"
      def version
        puts "mugatu #{Mugatu::VERSION}"
      end

      default_task :lint

      def self.source_root
        File.expand_path("../../../seeds", File.dirname(__FILE__))
      end

      private

      def bootloader
        Mugatu::Bootloader.new(root_path: destination_root, registry: registry)
      end

      def registry
        [
          Mugatu::Drivers::RubocopRunner
        ]
      end
    end
  end
end
