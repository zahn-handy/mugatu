require "test_helper"

class FashionShowTest < TestCase
  test "#runways generates runways appropriate to provided config" do
    show = Mugatu::FashionShow.new(
      linters_config:   fixture_config["linters"],
      linters_registry: [],
      root:             sandbox_path
    )
    runways = show.runways

    binding.pry

    assert_instance_of Mugatu::Runway, runways.first
  end

  private

  def fixture_config
    YAML.load_file(fixture_path("rubocop_and_eslint.yml"))
  end
end
