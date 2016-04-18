module Mugatu
  class FileMatcher
    def initialize(bucket_matchers)
      @matchers = bucket_matchers
    end

    def bucket(filenames)
      filenames.reduce({}) do |result, filename|
        @matchers.each do |matcher|
          if matcher.belongs?(filename)
            result[matcher.name] ||= []
            result[matcher.name].push(filename)
          end
        end

        result
      end
    end
  end
end
