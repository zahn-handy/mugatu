require "test_helper"

class ApplicationTest < TestCase
  def setup
  end

  test "#lint returns an array of Problems" do
    problems = application.lint(%w(horrible_file.rb))

    assert_equal(3, problems.count)
    assert_kind_of(Mugatu::Problem, problems.first)
  end

  private

  def application
    Mugatu::Application.new(
      processor_builder: processor_builder
    )
  end

  def processor_builder
    fixture_config = YAML.load_file(fixture_path("rubocop.yml"))

    Mugatu::ProcessorBuilder.new(
      linters_config:   fixture_config["linters"],
      linters_registry: [Mugatu::Drivers::RubocopDriver],
      root:             fixtures_path
    )
  end
end
