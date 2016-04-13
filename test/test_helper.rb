$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mugatu'

require 'pry-byebug'
require 'minitest/autorun'
require_relative "support/declarative"

class TestCase < Minitest::Test
  extend Support::Declarative

  def sandboxes_path
    File.expand_path("sandboxes", File.dirname(__FILE__))
  end

  def sandbox_path
    @sandbox_path ||= File.join(sandboxes_path, "mugatu_test_#{random_string}")
  end

  def random_string(length = 8)
    ("a".."z")
      .to_a
      .shuffle
      .slice(0, length)
      .join
  end

  def git_init
    if File.exist?(sandbox_path)
      raise "can't run tests, sandbox already exists"
    end

    Dir.mkdir(sandbox_path)

    Dir.chdir(sandbox_path) do
      Cocaine::CommandLine.new("git", "init").run
    end
  end

  def sandbox_clean
    FileUtils.rm_rf(sandbox_path)
  end
end
