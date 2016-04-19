module Mugatu
  class RubocopRunner
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
          cmd = Cocaine::CommandLine.new("rubocop", "--format json #{changed_files_keys}")
          cmd.run(changed_files_association)
        end

      # parser = RubocopParser.new(output)
      # parser.call
    end
  end
end
