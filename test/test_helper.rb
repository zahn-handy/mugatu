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

  def git_commit_all(msg = "test")
    Dir.chdir(sandbox_path) do
      Cocaine::CommandLine.new("git", "add .").run
      Cocaine::CommandLine.new("git", "commit -m :message").run(message: msg)
    end
  end

  def git_status
    Dir.chdir(sandbox_path) do
      $stderr.puts Cocaine::CommandLine.new("git", "status").run
    end
  end

  def git_log
    Dir.chdir(sandbox_path) do
      $stderr.puts Cocaine::CommandLine.new("git", "log --patch --reverse").run
    end
  end

  def sandbox_clean
    if within_directory?(file: sandbox_path, dir: sandboxes_path)
      FileUtils.rm_rf(sandbox_path)
    else
      $stderr.puts "attempted to delete `#{sandbox_path}` outside of sandboxes path"
    end
  end

  def touch(path, contents = nil)
    absolute = File.expand_path(path, sandbox_path)

    if within_directory?(file: absolute, dir: sandbox_path)
      File.write(absolute, contents || "")
    else
      $stderr.puts "attempted to write `#{absolute}` outside of the sandbox"
    end
  end

  def rm(path)
    absolute = File.expand_path(path, sandbox_path)

    if within_directory?(file: absolute, dir: sandbox_path)
      File.delete(absolute)
    else
      $stderr.puts "attempted to delete `#{absolute}` outside of the sandbox"
    end
  end

  def within_directory?(file:, dir:)
    filepath = Pathname.new(file)
    dirpath  = Pathname.new(dir)

    raise "filepath should be absolute" unless filepath.absolute?
    raise "dirpath should be absolute" unless dirpath.absolute?

    relpath = filepath.relative_path_from(dirpath)

    relpath.to_s.slice(0, 2) != ".."
  end
end
