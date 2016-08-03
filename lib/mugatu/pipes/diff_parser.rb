module Mugatu
  module Pipes
    class DiffParser
      def call(input)
        parser = Mugatu::DiffParser.new(input[:raw_diff])
        input[:additions] = parser.additions

        input
      end
    end
  end
end
