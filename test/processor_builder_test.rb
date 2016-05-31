require "test_helper"

class ProcessorBuilderTest < TestCase
  def setup
  end

  test "#runways generates runways appropriate to provided config" do
    show = Mugatu::ProcessorBuilder.new(
      linters_config:   fixture_config["linters"],
      linters_registry: [],
      root:             sandbox_path
    )
    runways = show.runways

    assert_instance_of(Mugatu::Processor, runways.first)
  end

  private

  def fixture_config
    YAML.load_file(fixture_path("rubocop_and_eslint.yml"))
  end
end
