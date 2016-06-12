module Mugatu
  class Runtime
    def initialize(bootloader:, requested_files:, ref: nil)
      @bootloader = bootloader

      @ref =
        if ref
          ref
        else
          Todd::HashHelpers.dig(bootloader.config, "git", "base", "ref") || "HEAD"
        end

      @files =
        if requested_files.empty?
          Mugatu::Changesets::ChangesetSinceRef.new(bootloader.root_path, @ref)
        else
          Mugatu::Changesets::NullChangeset.new(files: requested_files)
        end
    end

    attr_reader :files, :ref
  end
end
