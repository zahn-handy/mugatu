module Mugatu
  module Pipes
    class Files
      def initialize(requested_files, root_path)
        @requested_files = requested_files
        @root_path = root_path
      end

      def call(branch_point:, **)
        if @requested_files.empty?
          Mugatu::Changesets::ChangesetSinceRef.new(@root_path, branch_point)
        else
          Mugatu::Changesets::NullChangeset.new(files: @requested_files)
        end
      end
    end
  end
end
