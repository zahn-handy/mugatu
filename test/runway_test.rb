require "test_helper"

class RunwayTest < TestCase
  test "#initialize" do
  end

  # test "#load_linters" do
  #   main = Mugatu::Main.new(File.dirname(__FILE__), registry, fixture_hash("rubocop_and_eslint.yml"))

  #   main.load_linters
  # end

  private

  def fixture_hash(fixture)
    YAML.load_file(fixture_path(fixture))
  end

  def registry
    r = Object.new

    r.define_singleton_method :linters do
      {
        rubocop: Object,
        eslint:  Object
      }
    end

    r
  end
end
