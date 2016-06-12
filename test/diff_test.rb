require "test_helper"

class DiffTest < TestCase
  def setup
    sandbox_init
  end

  def teardown
    sandbox_clean
  end

  test "#compute" do
    diff.compute
  end

  private

  def diff
    Mugatu::Diff.new(base: "master", compare: "HEAD")
  end
end
