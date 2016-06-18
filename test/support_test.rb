require "test_helper"

class SupportTest < TestCase
  test "integration of test helpers" do
    git_init
    assert(File.exist?(File.join(sandbox_path, ".git")))

    touch("new.rb", %(puts "new"\n))
    assert(File.exist?(File.join(sandbox_path, "new.rb")))

    git_commit_all "crazy commit message"

    rm("new.rb")
    refute(File.exist?(File.join(sandbox_path, "new.rb")))

    git_commit_all

    _out, err = capture_io { git_status }
    assert_match(/nothing to commit, working directory clean/, err)

    _out, err = capture_io { git_log }
    assert_match(/crazy commit message/, err)

    sandbox_clean
    refute File.exist?(File.join(sandbox_path))
  end

  test "#extract accesses __END__" do
    assert_equal %(puts "hi"\n), extract("section_1")
    assert_equal %(puts "bye"\n), extract("section_2")
    assert_equal %(  puts "@@"\n), extract("section_3")
  end
end

__END__

@@ section_1

puts "hi"

@@ section_2

puts "bye"

@@ section_3

  puts "@@"

