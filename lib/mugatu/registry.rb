module Mugatu
  class Registry
    def initialize
      @linters = {}
    end

    attr_reader :linters

    def register_linter(linter)
      @linters[linter.id] = linter
    end
  end
end
