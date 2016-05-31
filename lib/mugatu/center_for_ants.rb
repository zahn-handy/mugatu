module Mugatu
  class CenterForAnts
    include Enumerable

    def initialize(driver:, root:, files: [])
      @driver = driver
      @root   = root
      @files  = files
    end

    def each
      if !block_given?
        return enum_for(:each)
      end

      call.each(&Proc.new)
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
