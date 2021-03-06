require "test_helper"

class ChangesetTest < TestCase
  def setup
    sandbox_setup
  end

  def teardown
    sandbox_clean
  end

  test "#files returns all modified files" do
    cs = Mugatu::Changesets::ChangesetSinceRef.new(sandbox_path, "HEAD")
    changed_files = cs.each.to_a

    assert_includes(changed_files, "edit_unstaged.rb")
    assert_includes(changed_files, "new_unstaged.rb")
    refute_includes(changed_files, "new_staged.rb")
    refute_includes(changed_files, "edit_staged.rb")
    refute_includes(changed_files, "delete_staged.rb")
    refute_includes(changed_files, "delete_unstaged.rb")
  end
end
