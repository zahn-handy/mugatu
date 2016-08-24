require "test_helper"

class CliMainTest < TestCase
  test "integration of `mugatu lint` command" do
    capture_io do
      Dir.chdir root_path do
        Mugatu::Cli::Main.new(config, registry)
      end
    end
  end

  private

  def config
    config = Mugatu::Config.new(
      root_path: root_path,
      parsed_argv: {},
      foreign_argv: [],
      registry: registry
    )
  end

  def registry
    Mugatu::Registry.new
  end

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
