module Mugatu
  module Pipes
    class DiffParser
      def call(diff:, **)
        parser = Mugatu::DiffParser.new(diff)
        parser.additions
      end
    end
  end
end
