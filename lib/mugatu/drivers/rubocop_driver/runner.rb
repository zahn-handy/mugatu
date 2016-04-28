module Mugatu
  module Drivers
    module RubocopDriver
      class Runner
        def self.name
          :rubocop
        end

        def initialize(root:)
          @root = root
        end

        def call(changed_files)
          # TODO: changed_files_association should be a Tod
          changed_files_association =
            changed_files.map.with_index do |filename, index|
              ["file#{index}", filename]
            end.to_h

          changed_files_keys =
            changed_files_association
              .keys
              .map { |k| ":#{k}" }
              .join(" ")

          output =
            Dir.chdir(@root) do
              cmd = Cocaine::CommandLine.new(
                "rubocop",
                "--format json #{changed_files_keys}",
                expected_outcodes: [0, 1]
              )
              cmd.run(changed_files_association)
            end
        end
      end
    end
  end
end
