module Mugatu
  module Changesets
    class NullChangeset
      include Enumerable

      def initialize(files:)
        @files = files
      end

      def each
        if block_given?
          @files.each(&Proc.new)
        else
          enum_for(:each)
        end
      end
    end
  end
end
