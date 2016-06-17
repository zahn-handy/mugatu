require "test_helper"

class IntegrationTest < TestCase
  test "running the exe" do
    output = capture_subprocess_io do
      Dir.chdir(root_path) do
        @return = system("bundle exec exe/mugatu")
      end
    end

    assert_match("Search", output.first)
    assert_match("", output.last)
    assert_equal(true, @return)
  end
end
