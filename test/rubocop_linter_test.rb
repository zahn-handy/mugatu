class RubocopLinterTest < TestCase
  def setup
    sandbox_setup
  end

  def teardown
    sandbox_clean
  end

  test "integration" do
    r      = Mugatu::RubocopRunner.new(root: sandbox_path)
    errors = r.call(changed_files)
  end

  private

  def changed_files
    Mugatu::Changeset.new(sandbox_path).files
  end
end
