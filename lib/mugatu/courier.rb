module Mugatu
  class Courier
    def initialize(driver:, root:)
      @driver = driver
      @root   = root
    end

    def call(changed_files)
      runner = @driver::Runner.new(root: @root)

      result = runner.call(changed_files)
      result_hash = normalize_to_hash(result)

      parser = @driver::Parser.new
      parser.call(result_hash)
    end

    private

    def normalize_to_hash(object)
      if object.is_a?(String)
        JSON.parse(object)
      else
        object
      end
    end
  end
end
