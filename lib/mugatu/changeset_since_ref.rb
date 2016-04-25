module Mugatu
  class ChangesetSinceRef
    def initialize(root, ref)
      @root = root
      @ref  = ref
    end

    def files
      staged_modified_files + unstaged_files
    end

    private

    def staged_modified_files
      Dir.chdir(@root) do
        staged_modified_files_cmd.run(ref: @ref).split("\n")
      end
    end

    def unstaged_files
      Dir.chdir(@root) do
        unstaged_files_cmd.run.split("\n")
      end
    end

    def staged_modified_files_cmd
      Cocaine::CommandLine.new("git", "diff-index --name-only --diff-filter=M :ref")
    end

    def unstaged_files_cmd
      Cocaine::CommandLine.new("git", "ls-files --others --exclude-standard")
    end
  end
end