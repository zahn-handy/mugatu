module Mugatu
  module Changesets
    class NullChangeset
      def initialize(files:)
        @files = files
      end

      attr_reader :files
    end
  end
end
