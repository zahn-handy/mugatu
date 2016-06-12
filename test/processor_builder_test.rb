require "test_helper"

class ProcessorBuilderTest < TestCase
  test "#processors generates processors appropriate to provided config" do
    show = Mugatu::ProcessorBuilder.new(
      linters_config:   fixture_config["linters"],
      linters_registry: [],
      root:             sandbox_path
    )
    processors = show.processors([])

    assert_instance_of(Mugatu::Processor, processors.first)
  end

  private

  def fixture_config
    YAML.load_file(fixture_path("rubocop_and_eslint.yml"))
  end
end
