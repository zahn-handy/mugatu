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

          # application = bootloader.main
          fs = Mugatu::FashionShow.new(
            linters_config: bootloader.config["linters"],
            linters_registry: bootloader.linters,
            root: bootloader.root_path
          )

          runways = fs.runways

          application = Mugatu::Application.new(runways: runways)

          problems = application.lint(files_to_check)

          puts files_to_check.inspect
          puts problems
        end
      end
    end
  end
end
