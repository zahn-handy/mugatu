module Mugatu
  class Runway
    def initialize(name:, matcher:, linter:)
      @name    = name
      @matcher = matcher
      @linter  = linter
    end

    attr_reader :name

    def belongs?(file)
      @matcher.belongs?(file)
    end

    def errors(files)
      @linter.call(files)
    end
  end
end
