module Mugatu
  class Application
    def initialize(runways:)
      @runways = runways.map { |r| [r.name, r] }.to_h
    end

    def lint(all_files)
      fm = Mugatu::FileAssociator.new(@runways.values)
      buckets_of_files = fm.bucket(all_files)

      buckets_of_files.flat_map do |name, files|
        runway = @runways[name]
        runway.errors(files)
      end
    end
  end
end
