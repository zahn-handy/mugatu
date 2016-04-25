module Mugatu
  module Cli
    module Commands
      class Lint
        def initialize(bootloader, requested_files)
          files_to_check =
            if requested_files.empty?
              Mugatu::Changeset.new(bootloader.root_path).files
            else
              requested_files
            end

          application = bootloader.application

          problems = application.lint(files_to_check)

          puts files_to_check.inspect
          puts problems
        end
      end
    end
  end
end
