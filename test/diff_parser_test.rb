require "test_helper"

class DiffParserTest < TestCase
  def setup
  end

  test "#result does a decent first-pass parse" do
    dp = Mugatu::DiffParser.new(diff1)
    result = dp.result

    readme = result[0]
    readme.header

    # RESULT
    assert_equal(8, result.length)

    # SECTION CONTEXT (first)
    assert_equal(4, readme.header.length)
    assert_match(/TODO: Delete this/, readme.sections[0].context)

    # SECTION DIFF (first)
    assert_equal(2, readme.sections[0].diff.length)
    assert_match(/Add this line/, readme.sections[0].diff[0])
    assert_match(/this line is modified/, readme.sections[0].diff[1])
  end

  test "#additions provides list of files and stuff" do
    dp = Mugatu::DiffParser.new(diff1)
    additions = dp.additions

    pp additions
  end

  private

  def diff1
    extract("diff1").gsub("\\e", "\e")
  end
end

__END__

@@ diff1

\e[1mdiff --git a/README.md b/README.md\e[m
\e[1mindex 983e3b5..54a532f 100644\e[m
\e[1m--- a/README.md\e[m
\e[1m+++ b/README.md\e[m
\e[36m@@ -9 +9 @@\e[m \e[mTODO: Delete this and the text above, and describe your gem\e[m
\e[31m-Add this line to your application's Gemfile:\e[m
\e[32m+\e[m\e[32mhil lolhishdiflhasi this line is modified\e[m
\e[36m@@ -16,9 +15,0 @@\e[m \e[mAnd then execute:\e[m
\e[31m-\e[m
\e[31m-    $ bundle\e[m
\e[31m-\e[m
\e[31m-Or install it yourself as:\e[m
\e[31m-\e[m
\e[31m-    $ gem install mugatu\e[m
\e[31m-\e[m
\e[31m-## Usage\e[m
\e[31m-\e[m
\e[36m@@ -36,0 +28,6 @@\e[m \e[mBug reports and pull requests are welcome on GitHub at https://github.com/[USERN\e[m
\e[32m+\e[m\e[32masdf asdf\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32masdf\e[m
\e[32m+\e[m\e[32masdf\e[m
\e[32m+\e[m\e[32masdf\e[m
\e[32m+\e[m
\e[36m@@ -41,0 +39 @@\e[m \e[mClosed source. All rights reserved.\e[m
\e[32m+\e[m\e[32m@@ what now @@\e[m
\e[1mdiff --git a/Rakefile b/Rakefile\e[m
\e[1mdeleted file mode 100644\e[m
\e[1mindex 3d52175..0000000\e[m
\e[1m--- a/Rakefile\e[m
\e[1m+++ /dev/null\e[m
\e[36m@@ -1,10 +0,0 @@\e[m
\e[31m-require \"bundler/gem_tasks\"\e[m
\e[31m-require \"rake/testtask\"\e[m
\e[31m-\e[m
\e[31m-Rake::TestTask.new(:test) do |t|\e[m
\e[31m-  t.libs << \"test\"\e[m
\e[31m-  t.libs << \"lib\"\e[m
\e[31m-  t.test_files = FileList[\"test/**/*_test.rb\"]\e[m
\e[31m-end\e[m
\e[31m-\e[m
\e[31m-task default: :test\e[m
\e[1mdiff --git a/bin/console b/bin/console\e[m
\e[1mdeleted file mode 100755\e[m
\e[1mindex 0acea96..0000000\e[m
\e[1m--- a/bin/console\e[m
\e[1m+++ /dev/null\e[m
\e[36m@@ -1,14 +0,0 @@\e[m
\e[31m-#!/usr/bin/env ruby\e[m
\e[31m-\e[m
\e[31m-require \"bundler/setup\"\e[m
\e[31m-require \"mugatu\"\e[m
\e[31m-\e[m
\e[31m-# You can add fixtures and/or initialization code here to make experimenting\e[m
\e[31m-# with your gem easier. You can also use a different console, if you like.\e[m
\e[31m-\e[m
\e[31m-# (If you use this, don't forget to add pry to your Gemfile!)\e[m
\e[31m-# require \"pry\"\e[m
\e[31m-# Pry.start\e[m
\e[31m-\e[m
\e[31m-require \"irb\"\e[m
\e[31m-IRB.start\e[m
\e[1mdiff --git a/mugatu.gemspec b/fugatu.gemspec\e[m
\e[1msimilarity index 99%\e[m
\e[1mrename from mugatu.gemspec\e[m
\e[1mrename to fugatu.gemspec\e[m
\e[1mindex 09779a6..56fbc68 100644\e[m
\e[1m--- a/mugatu.gemspec\e[m
\e[1m+++ b/fugatu.gemspec\e[m
\e[36m@@ -5,0 +6,5 @@\e[m \e[mrequire \"mugatu/version\"\e[m
\e[32m+\e[m
\e[32m+\e[m
\e[32m+\e[m
\e[32m+\e[m
\e[32m+\e[m
\e[1mdiff --git a/lib/mugatu.rb b/lib/mugatu.rb\e[m
\e[1mindex 2fc14db..79c9935 100644\e[m
\e[1m--- a/lib/mugatu.rb\e[m
\e[1m+++ b/lib/mugatu.rb\e[m
\e[36m@@ -29,0 +30,2 @@\e[m \e[mrequire \"mugatu/processor\"\e[m
\e[32m+\e[m\e[32mrequire \"mugatu/diff\"\e[m
\e[32m+\e[m\e[32mrequire \"mugatu/diff_parser\"\e[m
\e[1mdiff --git a/lib/mugatu/diff.rb b/lib/mugatu/diff.rb\e[m
\e[1mnew file mode 100644\e[m
\e[1mindex 0000000..12eb013\e[m
\e[1m--- /dev/null\e[m
\e[1m+++ b/lib/mugatu/diff.rb\e[m
\e[36m@@ -0,0 +1,38 @@\e[m
\e[32m+\e[m\e[32mmodule Mugatu\e[m
\e[32m+\e[m\e[32m  class Diff\e[m
\e[32m+\e[m\e[32m    def initialize(base:, compare:)\e[m
\e[32m+\e[m\e[32m      @base = base\e[m
\e[32m+\e[m\e[32m      @compute = compare\e[m
\e[32m+\e[m\e[32m    end\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32m    def compute\e[m
\e[32m+\e[m\e[32m      git_diff_command.run(base: @base, compare: @compare)\e[m
\e[32m+\e[m\e[32m    end\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32m    # This `git diff` command doesn't include files that haven't been comitted.\e[m
\e[32m+\e[m\e[32m    # A workaround would be to first do a `git add .`, but that kinda sucks.\e[m
\e[32m+\e[m\e[32m    # In my research, I've found nothing that finds exactly what I want\e[m
\e[32m+\e[m\e[32m    #\e[m
\e[32m+\e[m\e[32m    # It kinda makes sense why what I want doesn't exist. There are three\e[m
\e[32m+\e[m\e[32m    # categories in git:\e[m
\e[32m+\e[m\e[32m    #\e[m
\e[32m+\e[m\e[32m    # - \"Commit history\"\e[m
\e[32m+\e[m\e[32m    # - Staged\e[m
\e[32m+\e[m\e[32m    # - Unstaged / working tree\e[m
\e[32m+\e[m\e[32m    #\e[m
\e[32m+\e[m\e[32m    # Staged files have a sha1 hash (which effictively means that the file\e[m
\e[32m+\e[m\e[32m    # contents are cached). If it were possible to `git diff` the working tree,\e[m
\e[32m+\e[m\e[32m    # Git would have lots of trash blobs stored.\e[m
\e[32m+\e[m\e[32m    def git_diff_command\e[m
\e[32m+\e[m\e[32m      Cocaine::CommandLine.new(\e[m
\e[32m+\e[m\e[32m        \"git\",\e[m
\e[32m+\e[m\e[32m        \"diff \" +\e[m
\e[32m+\e[m\e[32m        \"--unified=0 \" +\e[m
\e[32m+\e[m\e[32m        \"--color=always \" +\e[m
\e[32m+\e[m\e[32m        \"--find-renames \" +\e[m
\e[32m+\e[m\e[32m        \"--diff-algorithm=histogram \" +\e[m
\e[32m+\e[m\e[32m        \":base :compare\"\e[m
\e[32m+\e[m\e[32m      )\e[m
\e[32m+\e[m\e[32m    end\e[m
\e[32m+\e[m\e[32m  end\e[m
\e[32m+\e[m\e[32mend\e[m
\e[1mdiff --git a/test/cli/commands/lint_test.rb b/test/cli/commands/lint_test.rb\e[m
\e[1mindex c54aec7..60b7391 100644\e[m
\e[1m--- a/test/cli/commands/lint_test.rb\e[m
\e[1m+++ b/test/cli/commands/lint_test.rb\e[m
\e[36m@@ -13,0 +14 @@\e[m \e[mclass CliCommandsLintTest < TestCase\e[m
\e[32m+\e[m\e[32m    binding.pry\e[m
\e[1mdiff --git a/test/diff_test.rb b/test/diff_test.rb\e[m
\e[1mnew file mode 100644\e[m
\e[1mindex 0000000..0a15372\e[m
\e[1m--- /dev/null\e[m
\e[1m+++ b/test/diff_test.rb\e[m
\e[36m@@ -0,0 +1,21 @@\e[m
\e[32m+\e[m\e[32mrequire \"test_helper\"\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32mclass DiffTest < TestCase\e[m
\e[32m+\e[m\e[32m  def setup\e[m
\e[32m+\e[m\e[32m    sandbox_init\e[m
\e[32m+\e[m\e[32m  end\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32m  def teardown\e[m
\e[32m+\e[m\e[32m    sandbox_clean\e[m
\e[32m+\e[m\e[32m  end\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32m  test \"#compute\" do\e[m
\e[32m+\e[m\e[32m    puts diff.compute.inspect\e[m
\e[32m+\e[m\e[32m  end\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32m  private\e[m
\e[32m+\e[m
\e[32m+\e[m\e[32m  def diff\e[m
\e[32m+\e[m\e[32m    Mugatu::Diff.new(base: \"master\", compare: \"HEAD\")\e[m
\e[32m+\e[m\e[32m  end\e[m
\e[32m+\e[m\e[32mend\e[m
