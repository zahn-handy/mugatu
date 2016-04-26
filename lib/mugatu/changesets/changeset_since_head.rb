module Mugatu
  module Changesets
    class ChangesetSinceHead
      def initialize(root)
        @root = root
      end

      def files
        modified - deleted
      end

      private

      def deleted
        Dir.chdir(@root) do
          ls_files_deleted
            .run
            .split("\n")
        end
      end

      def modified
        Dir.chdir(@root) do
          ls_files_modified
            .run
            .split("\n")
        end
      end

      def ls_files_modified
        Cocaine::CommandLine.new("git", "ls-files --others --modified --exclude-standard")
      end

      def ls_files_deleted
        Cocaine::CommandLine.new("git", "ls-files --deleted")
      end
    end
  end
end
