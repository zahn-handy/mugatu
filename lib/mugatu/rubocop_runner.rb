module Mugatu
  class RubocopRunner
    def self.name
      :rubocop
    end

    def initialize(root:)
      @root = root
    end

    def call(changed_files)
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

      parser = RubocopParser.new
      parser.call(output)
    end
  end
end
