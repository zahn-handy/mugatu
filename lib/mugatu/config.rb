module Mugatu
  class Config
    def initialize(root_path:, parsed_argv:, foreign_argv:, dotfile_contents:)
      @root_path = root_path
      @parsed_argv = parsed_argv
      @foreign_argv = foreign_argv
      @dotfile_contents = dotfile_contents
    end

    attr_reader :root_path

    def requested_files
      @foreign_argv
    end

    def base_ref
      @dotfile_contents["git"]["base"]["ref"]
    end

    def current_ref
      "HEAD"
    end

    def linter_config
      @dotfile_contents["linters"]
    end
  end
end
