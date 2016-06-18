module Mugatu
  module Drivers
    module RubocopDriver
      class Runner
        def self.name
          :rubocop
        end

        def initialize(root:)
          @root = root
        end

        def call(changed_files)
          output =
            Dir.chdir(@root) do
              Todd::System.call(
                "rubocop",
                "--format", "json",
                *changed_files
              )
            end

          JSON.parse(output)
        end
      end
    end
  end
end
