module Mugatu
  class Application
    def initialize(processor_builder:)
      @processor_builder = processor_builder
    end

    def lint(all_files)
      runways = @processor_builder.runways(all_files)

      runways.flat_map do |runway|
        runway.each.to_a
      end
    end
  end
end
