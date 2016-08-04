module Mugatu
  module Pipes
    class DiffParser
      def call(raw_diff)
        parser = Mugatu::DiffParser.new(raw_diff)
        parser.additions
      end
    end
  end
end
