module Mugatu
  class Runtime
    def initialize(bootloader:, requested_files:, ref:, options:)
      @bootloader = bootloader
      @requested_files = requested_files
      @ref = ref
      @options = options
    end

    attr_reader :formatter

    def ref
      if @ref
        @ref
      else
        Todd::HashHelpers.dig(@bootloader.config, "git", "base", "ref") || "HEAD"
      end
    end

    def files
      if @requested_files.empty?
        Mugatu::Changesets::ChangesetSinceRef.new(@bootloader.root_path, ref)
      else
        Mugatu::Changesets::NullChangeset.new(files: @requested_files)
      end
    end

    def formatter
      case @options[:format]
      when :json
        Mugatu::Formatters::Json
      else
        Mugatu::Formatters::Pretty
      end
    end
  end
end
