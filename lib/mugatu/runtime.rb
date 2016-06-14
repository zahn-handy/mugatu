module Mugatu
  class Runtime
    def initialize(bootloader:, requested_files:, ref:, options:)
      @bootloader = bootloader
      @requested_files = requested_files
      @ref = ref
      @options = options
    end

    attr_reader :bootloader

    def additions
      diff = Mugatu::Diff.new(base: ref, compare: "HEAD").compute
      additions = Mugatu::DiffParser.new(diff).additions
      additions.group_by(&:filename)
    end

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

    def formatter_hash
      formatters.map do |formatter|
        [formatter.identifier, formatter]
      end.to_h
    end

    def formatters
      Mugatu::Formatters.constants.map do |formatter_class_name|
        Mugatu::Formatters.const_get(formatter_class_name)
      end
    end

    def formatter
      found_formatter = formatter_hash[@options[:format]]

      if found_formatter
        found_formatter
      else
        Mugatu::Formatters::Pretty
      end
    end
  end
end
