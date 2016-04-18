module Mugatu
  class Bucket
    def initialize(base:, excludes:, includes:)
      @base     = base
      @excludes = excludes
      @includes = includes 
    end

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
      patterns.each do |pattern|
        if File.fnmatch?(pattern, subject)
          return true
        end
      end

      false
    end
  end
end
