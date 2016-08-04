module Mugatu
  module Pipes
    class Linter
      def initialize(application)
        @application = application
      end

      def call(files:, **)
        @application.lint(files)
      end
    end
  end
end
