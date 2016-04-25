module Mugatu
  module Cli
    module Commands
      class Lint
        def initialize(bootloader, requested_files, options)
          ref =
            if options[:ref]
              options[:ref]
            else
              dig(bootloader.config, "git", "base", "ref") || "HEAD"
            end

          files_to_check =
            if requested_files.empty?
              Mugatu::ChangesetSinceRef.new(bootloader.root_path, ref).files
            else
              requested_files
            end

          application = bootloader.application

          problems = application.lint(files_to_check)

          puts files_to_check.inspect
          puts problems
        end

        private

        # TODO: Extract to HashUtils helper module
        def dig(hash, *keys)
          head, *tail = keys

          if hash[head].is_a?(Hash)
            dig(hash[head], *tail)
          else
            hash[head]
          end
        end
      end
    end
  end
end
