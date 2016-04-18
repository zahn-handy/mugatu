require "test_helper"

class FileMatcherTest < TestCase
  test "integration" do
    fm = Mugatu::FileMatcher.new([dummy_bucket(:rubocop, ".rb"), dummy_bucket(:eslint, ".js")])

    filenames = %w(
      form.jsx
      jquery.js
      react.js
      app/models/user.rb
      app/controllers/users_controller.rb
    )

    buckets = fm.bucket(filenames)

    assert_equal %w(jquery.js react.js), buckets[:eslint].sort
    assert_equal %w(app/controllers/users_controller.rb app/models/user.rb), buckets[:rubocop].sort
  end

  private

  def dummy_bucket(name, extension)
    dummy = Object.new

    dummy.define_singleton_method :name do
      name
    end

    dummy.define_singleton_method :belongs? do |file|
      File.extname(file) == extension
    end

    dummy
  end
end
