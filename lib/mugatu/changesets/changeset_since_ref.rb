module Mugatu
  module Changesets
    class ChangesetSinceRef
      include Enumerable

      def initialize(root, ref)
        @root = root
        @ref  = ref
      end

      def each
        if block_given?
          files.each(&Proc.new)
        else
          enum_for(:each)
        end
      end

      def inspect
        "#<#{self.class.name} #{to_a.inspect}>"
      end

      private

      def files
        (committed_modified_files + staged_modified_files + unstaged_files).uniq
      end

      def committed_modified_files
        Dir.chdir(@root) do
          committed_modified_files_cmd(ref: @ref).split("\n")
        end
      end

      def staged_modified_files
        Dir.chdir(@root) do
          staged_modified_files_cmd(ref: @ref).split("\n")
        end
      end

      def unstaged_files
        Dir.chdir(@root) do
          unstaged_files_cmd.split("\n")
        end
      end

      def committed_modified_files_cmd(ref:)
        Todd::System.call(
          "git", "diff",
          "--name-only",
          "--diff-filter=AM",
          ref
        )
      end

      def staged_modified_files_cmd(ref:)
        Todd::System.call(
          "git", "diff-index",
          "--name-only",
          "--diff-filter=AM",
          ref
        )
      end

      def unstaged_files_cmd
        Todd::System.call(
          "git", "ls-files",
          "--others",
          "--exclude-standard"
        )
      end
    end
  end
end
