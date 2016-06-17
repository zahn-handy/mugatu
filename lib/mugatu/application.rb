module Mugatu
  class Application
    def initialize(processor_builder:)
      @processor_builder = processor_builder
    end

    def lint(all_files)
      processors = @processor_builder.processors(all_files)

      processors.flat_map do |processor|
        processor.each.to_a
      end
    end
  end
end
