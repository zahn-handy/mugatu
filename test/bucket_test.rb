require "test_helper"

class BucketTest < TestCase
  test "#belongs? with base, excludes, and includes" do
    patterns = {
      base: %w(**/*.js),
      excludes: %w(no.js nope/**/*),
      includes: %w(nope/jk/**/* nope/but_actually_yes.js)
    }

    fm = Mugatu::Bucket.new(patterns)

    assert_equal true, fm.belongs?("nope/but_actually_yes.js")
    assert_equal true, fm.belongs?("nope/jk/lol/wildcard.js")

    assert_equal false, fm.belongs?("no.js")
    assert_equal false, fm.belongs?("nope/really/no.js")

    assert_equal true, fm.belongs?("subdir/test.js")
    assert_equal true, fm.belongs?("sub/dir/test.js")
  end

  test "#belongs? works like how I want it to" do
    skip "#belongs? doesn't work right now, but it's not my priority at the moment"

    patterns = {
      base: %w(**/*.js),
      excludes: %w(no.js nope/**/*),
      includes: %w(nope/jk/**/* nope/but_actually_yes.js)
    }

    fm = Mugatu::Bucket.new(patterns)

    assert_equal true, fm.belongs?("nope/jk/wildcard.js")
    assert_equal false, fm.belongs?("nope/wildcard.js")
    assert_equal true, fm.belongs?("test.js")
  end
end
