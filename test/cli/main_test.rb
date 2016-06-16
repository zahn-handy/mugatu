require "test_helper"

class CliMainTest < TestCase
  test "integration of `mugatu lint` command" do
    capture_io do
      Dir.chdir root_path do
        Mugatu::Cli::Main.new(
          runtime
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

  def runtime
    Mugatu::Runtime.new(
      bootloader: bootloader,
      requested_files: [],
      ref: "HEAD",
      options: {}
    )
  end
end
