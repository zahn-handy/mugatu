require "test_helper"

class CliCommandsLintTest < TestCase
  test "integration of `mugatu lint` command" do
    capture_io do
      Dir.chdir root_path do
        Mugatu::Cli::Commands::Lint.new(
          bootloader,
          [],
          {}
        )
      end
    end
  end

  private

  def bootloader
    Mugatu::Bootloader.new(
      root_path: root_path,
      registry: [
        Mugatu::Drivers::RubocopDriver
      ]
    )
  end
end
