module Mugatu
  module Cli
    module Commands
      class Lint
        def initialize(bootloader, requested_files, options)
          start_time = Time.now
          runtime = Mugatu::Runtime.new(bootloader: bootloader, requested_files: requested_files, ref: options[:ref])
          diff = Mugatu::Diff.new(base: runtime.ref, compare: "HEAD").compute
          additions = Mugatu::DiffParser.new(diff).additions
          additions_hash = additions.group_by { |addition| addition.filename }

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

          formatter = Mugatu::Formatters::Pretty.new
          formatter.start(
            additions: additions_hash,
            files: runtime.files,
            start_time: start_time
          )
          printable_problems.each { |p| formatter.problem(p) }
          formatter.done
        end
      end
    end
  end
end
