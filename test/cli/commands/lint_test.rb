require "test_helper"

class CliCommandsLintTest < TestCase
  def setup
    sandbox_init

    FileUtils.cp(
      fixture_path("rubocop.yml"),
      File.join(sandbox_path, ".mugatu.yml")
    )
  end

  def teardown
    sandbox_clean
  end

  test "integration of `mugatu lint` command" do
    Mugatu::Cli::Commands::Lint.new(
      bootloader,
      [],
      {}
    )
  end

  private

  def bootloader
    Mugatu::Bootloader.new(
      root_path: sandbox_path,
      registry: [
        Mugatu::Drivers::RubocopDriver
      ]
    )
  end
end
