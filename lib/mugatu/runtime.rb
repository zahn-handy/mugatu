module Mugatu
  class Runtime
    def initialize(bootloader:, requested_files:, ref: nil)
      @bootloader = bootloader

      @ref =
        if ref
          ref
        else
          dig(bootloader.config, "git", "base", "ref") || "HEAD"
        end

      @files =
        if requested_files.empty?
          Mugatu::ChangesetSinceRef.new(bootloader.root_path, @ref).files
        else
          requested_files
        end
    end

    attr_reader :files, :ref

    private

    # TODO: Extract to HashUtils helper module
    def dig(hash, *keys)
      head, *tail = keys

      if hash[head].is_a?(Hash)
        dig(hash[head], *tail)
      else
        hash[head]
      end
    end
  end
end
