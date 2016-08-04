module Mugatu
  module Pipes
    class Linter
      def initialize(application)
        @application = application
      end

      def call(additions)
        # @application.lint

        {
          additions: additions,
          problems: []
        }
      end
    end
  end
end
