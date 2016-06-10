require "pp"

module Mugatu
  module Cli
    module Commands
      class Lint
        def initialize(bootloader, requested_files, options)
          runtime = Mugatu::Runtime.new(bootloader: bootloader, requested_files: requested_files, ref: options[:ref])
          diff = Mugatu::Diff.new(base: runtime.ref, compare: "HEAD").compute
          additions = Mugatu::DiffParser.new(diff).additions
          additions_hash = additions.group_by { |addition| addition.filename }
          pp additions_hash

          application = bootloader.application

          problems = application.lint(runtime.files)

          printable_problems =
            problems.select do |problem|
              contexts = additions_hash[problem.file]

              if contexts.nil?
                puts problem.file
                true
              else
                contexts.any? do |context|
                  context.lines.include?(problem.line)
                end
              end
            end

          pp runtime.files
          puts problems.map(&:to_s).join("\n\n")
          puts "😭 😭 😭 😭 😭 😭 😭 😭 😭 😭 😭 😭 😭 😭 😭 😭 "
          puts printable_problems.map(&:to_s).join("\n\n")
        end
      end
    end
  end
end
