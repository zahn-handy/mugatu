require "test_helper"

class ProblemTest < TestCase
  test "initialization and accessors (acts like a struct)" do
    problem =
      Mugatu::Problem.new(
        linter: Object,
        name: "name of violation",
        message: "Description of violation",
        severity: :error,
        file: "path/to/file.rb",
        line: 3,
        column: 8,
        length: 20,
        range: (0..2)
      )

    assert_equal Object, problem.linter
  end
end
