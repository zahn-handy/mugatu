require "test_helper"

class CenterForAntsTest < TestCase
  def setup
  end

  test "#each without a block returns an Enumerator of problems" do
    assert_kind_of(Enumerable, center_for_ants.each)
  end

  test "#each accepts a block" do
    run_count = 0
    center_for_ants.each do |problem|
      assert_kind_of(Mugatu::Problem, problem)
      run_count += 1
    end

    assert_equal(3, run_count)
  end

  private

  def center_for_ants
    Mugatu::CenterForAnts.new(
      driver: Mugatu::Drivers::RubocopDriver,
      root: File.dirname(__FILE__),
      files: %w(fixtures/horrible_file.rb)
    )
  end
end
