require "test_helper"

class BootloaderTest < TestCase
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

  test "#application" do
    bootloader.application
  end

  private

  def bootloader
    Mugatu::Bootloader.new(
      root_path: sandbox_path,
      registry: registry
    )
  end

  def registry
    [
      Mugatu::Drivers::RubocopDriver
    ]
  end
end
