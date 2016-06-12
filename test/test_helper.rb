$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "mugatu"
require "mugatu/cli"

require "ostruct"
require "pp"

require "pry-byebug"
require "minitest/autorun"
require_relative "support/declarative"
require_relative "support/quick_dummy"

class TestCase < Minitest::Test
  extend Support::Declarative

  def sandboxes_path
    File.expand_path("sandboxes", File.dirname(__FILE__))
  end

  def sandbox_path
    @sandbox_path ||= File.join(sandboxes_path, "mugatu_test_#{random_string}")
  end

  def root_path
    File.expand_path("../..", __FILE__)
  end

  def random_string(length = 8)
    ("a".."z")
      .to_a
      .shuffle
      .slice(0, length)
      .join
  end

  def sandbox_init
    if File.exist?(sandbox_path)
      raise "can't run tests, sandbox already exists"
    end

    if !File.exist?(sandboxes_path)
      Dir.mkdir(sandboxes_path)
    end

    if !File.exist?(sandbox_path)
      Dir.mkdir(sandbox_path)
    end
  end

  def git_init
    sandbox_init

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

  def sandbox_setup
    git_init

    touch "new_staged.rb", %(puts "new"\n)
    touch "edit_staged.rb", %(puts "edit me"\n)
    touch "delete_staged.rb", %(puts "delete me"\n)
    touch "edit_unstaged.rb", %(puts "edit me too"\n)
    touch "delete_unstaged.rb", %(puts "delete me"\n)

    git_commit_all "initial commit"

    rm "delete_staged.rb"
    touch "edit_staged.rb", %(puts "edited"\n)

    git_commit_all

    touch "new_unstaged.rb"
    touch "edit_unstaged.rb", %(puts "unstaged edit"\n)
    rm "delete_unstaged.rb"
  end

  def sandbox_horrible
    FileUtils.cp(fixture_path("horrible_file.rb"), sandbox_path)
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

  def extract(name)
    file     = caller_locations(1, 1).first.absolute_path
    contents = File.read(file)
    post_end = contents.split(/^__END__$/, 2).last || ""
    matches  = post_end.strip.match(/(?:(@@\s*[^\n]*)\n([^(@@)]+)+)/m).to_a
    sections =
      post_end
        .split(/^@@\s*/)
        .map(&:rstrip)
        .select { |s| s.length > 0 }
        .map    { |section| section.split("\n", 2) }
        .to_h

    sections[name].sub(/^\n*/, "") + "\n"
  end

  def fixtures_path
    File.expand_path("fixtures", File.dirname(__FILE__))
  end

  def fixture_path(partial_path)
    File.join(fixtures_path, partial_path)
  end
end
