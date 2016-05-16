class RubocopLinterTest < TestCase
  def setup
    sandbox_setup
  end

  def teardown
    sandbox_clean
  end

  test "integration" do
    r      = Mugatu::Drivers::RubocopDriver::Runner.new(root: sandbox_path)
    errors = r.call(changed_files)
  end

  private

  def changed_files
    Mugatu::Changesets::ChangesetSinceHead.new(sandbox_path).files
  end
end
