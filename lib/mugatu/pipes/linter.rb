module Mugatu
  module Pipes
    class Linter
      def call(processor_builder:, files:, **)
        processors = processor_builder.processors(files)

        processors.flat_map do |processor|
          processor.each.to_a
        end
      end
    end
  end
end
