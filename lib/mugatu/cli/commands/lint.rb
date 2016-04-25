module Mugatu
  module Cli
    module Commands
      class Lint
        def initialize(bootloader, requested_files, options)
          runtime = Mugatu::Runtime.new(bootloader: bootloader, requested_files: requested_files, ref: options[:ref])

          application = bootloader.application

          problems = application.lint(runtime.files)

          puts runtime.files.inspect
          puts problems.map(&:to_s).join("\n\n")
        end
      end
    end
  end
end
