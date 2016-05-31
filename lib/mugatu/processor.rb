module Mugatu
  class Processor
    include Enumerable

    def initialize(driver:, matcher:, root:, files: [])
      @driver = driver
      @matcher = matcher
      @root   = root
      @files  = files
    end

    def each
      if !block_given?
        return enum_for(:each)
      end

      call.each(&Proc.new)
    end

    def pertinent_files
      @files.select do |file|
        @matcher.belongs?(file)
      end
    end

    private

    def call(changed_files = nil)
      runner = @driver::Runner.new(root: @root)

      result = runner.call(changed_files || @files)
      result_hash = normalize_to_hash(result)

      parser = @driver::Parser.new
      parser.call(result_hash)
    end

    def normalize_to_hash(object)
      if object.is_a?(String)
        JSON.parse(object)
      else
        object
      end
    end
  end
end
