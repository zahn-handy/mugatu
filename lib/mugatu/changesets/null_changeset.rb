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

      def inspect
        "#<#{self.class.name} #{to_a.inspect}>"
      end
    end
  end
end
