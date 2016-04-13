module Mugatu
  class Changeset
    def initialize(root)
      @root = root
    end

    def all
      Dir.chdir(@root) do
        ls_files
          .run
          .split("\n")
      end
    end

    private

    def ls_files
      Cocaine::CommandLine.new("git", "ls-files --others --modified --exclude-standard")
    end
  end
end
