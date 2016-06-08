module Mugatu
  class Diff
    def initialize(base:, compare:)
      @base = base
      @compute = compare
    end

    def compute
      git_diff_command.run(base: @base, compare: @compare)
    end

    # This `git diff` command doesn't include files that haven't been comitted.
    # A workaround would be to first do a `git add .`, but that kinda sucks.
    # In my research, I've found nothing that finds exactly what I want
    #
    # It kinda makes sense why what I want doesn't exist. There are three
    # categories in git:
    #
    # - "Commit history"
    # - Staged
    # - Unstaged / working tree
    #
    # Staged files have a sha1 hash (which effictively means that the file
    # contents are cached). If it were possible to `git diff` the working tree,
    # Git would have lots of trash blobs stored.
    def git_diff_command
      Cocaine::CommandLine.new(
        "git",
        "diff " +
        "--unified=0 " +
        "--color=always " +
        "--find-renames " +
        "--diff-algorithm=histogram " +
        ":base :compare"
      )
    end
  end
end
