module Mugatu
  class Matcher
    def initialize(name:, base:, excludes:, includes:)
      @name     = name
      @base     = base
      @excludes = excludes
      @includes = includes
    end

    attr_reader :name

    def belongs?(file)
      if match?(@includes, file)
        return true
      end

      if match?(@excludes, file)
        return false
      end

      if match?(@base, file)
        return true
      end

      false
    end

    private

    def match?(patterns, subject)
      safe_patterns = patterns || []
      safe_patterns.each do |pattern|
        if File.fnmatch?(pattern, subject)
          return true
        end
      end

      false
    end
  end
end
