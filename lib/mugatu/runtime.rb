module Mugatu
  class Runtime
    def initialize(bootloader:, requested_files:, ref: nil)
      @bootloader = bootloader

      @ref =
        if ref
          ref
        else
          Tod::HashHelpers.dig(bootloader.config, "git", "base", "ref") || "HEAD"
        end

      @files =
        if requested_files.empty?
          Mugatu::Changesets::ChangesetSinceRef.new(bootloader.root_path, @ref).files
        else
          Mugatu::Changesets::NullChangeset.new(files: requested_files).files
        end
    end

    attr_reader :files, :ref
  end
end
