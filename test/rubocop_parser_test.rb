require "test_helper"

class RubocopParserTest < TestCase
  def setup
  end

  test "#parse_offense" do
    offense = extract("single")
    parser  = Mugatu::Drivers::RubocopDriver::Parser.new
    problem = parser.parse_offense("path/to/file.rb", JSON.parse(offense))

    assert_kind_of(Mugatu::Problem, problem)
    assert_equal("path/to/file.rb", problem.file)
    assert_equal("Metrics/ParameterLists", problem.name)
  end

  test "sets severity to predefined set" do
    skip
  end

  test "#parse_many_offenses" do
    offenses = extract("multiple")
    parser  = Mugatu::Drivers::RubocopDriver::Parser.new

    problems = parser.parse_many_offenses("path/to/bad/file.rb", JSON.parse(offenses))

    assert_equal(3, problems.length)
    assert_equal("path/to/bad/file.rb", problems.first.file)
    assert_equal(13, problems.first.line)
    assert_equal(20, problems.last.line)
  end

  test "#call parses real stuff" do
    json = extract("real")

    parser   = Mugatu::Drivers::RubocopDriver::Parser.new
    problems = parser.call(json)

    assert_equal(6, problems.length)
  end
end

__END__

@@ single

{
  "severity": "convention",
  "message": "Avoid parameter lists longer than 5 parameters.",
  "cop_name": "Metrics/ParameterLists",
  "corrected": null,
  "location": {
    "line": 3,
    "column": 19,
    "length": 59
  }
}

@@ multiple

[{
  "severity": "warning",
  "message": "Remove debugger entry point `binding.pry`.",
  "cop_name": "Lint/Debugger",
  "corrected": false,
  "location": {
    "line": 13,
    "column": 7,
    "length": 11
  }
}, {
  "severity": "warning",
  "message": "Unused method argument - `file`. If it's necessary, use `_` or `_file` as an argument name to indicate that it won't be used.",
  "cop_name": "Lint/UnusedMethodArgument",
  "corrected": false,
  "location": {
    "line": 18,
    "column": 30,
    "length": 4
  }
}, {
  "severity": "warning",
  "message": "Unreachable code detected.",
  "cop_name": "Lint/UnreachableCode",
  "corrected": null,
  "location": {
    "line": 20,
    "column": 7,
    "length": 49
  }
}]

@@ real

{
  "metadata": {
    "rubocop_version": "0.39.0",
    "ruby_engine": "ruby",
    "ruby_version": "2.3.0",
    "ruby_patchlevel": "0",
    "ruby_platform": "x86_64-darwin15"
  },
  "files": [{
    "path": "lib/mugatu/configs/linter_config.rb",
    "offenses": []
  }, {
    "path": "lib/mugatu/problem.rb",
    "offenses": [{
      "severity": "convention",
      "message": "Avoid parameter lists longer than 5 parameters.",
      "cop_name": "Metrics/ParameterLists",
      "corrected": null,
      "location": {
        "line": 3,
        "column": 19,
        "length": 59
      }
    }]
  }, {
    "path": "lib/mugatu/rubocop_parser.rb",
    "offenses": [{
      "severity": "warning",
      "message": "Remove debugger entry point `binding.pry`.",
      "cop_name": "Lint/Debugger",
      "corrected": false,
      "location": {
        "line": 13,
        "column": 7,
        "length": 11
      }
    }, {
      "severity": "warning",
      "message": "Unused method argument - `file`. If it's necessary, use `_` or `_file` as an argument name to indicate that it won't be used.",
      "cop_name": "Lint/UnusedMethodArgument",
      "corrected": false,
      "location": {
        "line": 18,
        "column": 30,
        "length": 4
      }
    }, {
      "severity": "warning",
      "message": "Unreachable code detected.",
      "cop_name": "Lint/UnreachableCode",
      "corrected": null,
      "location": {
        "line": 20,
        "column": 7,
        "length": 49
      }
    }, {
      "severity": "warning",
      "message": "Unused block argument - `offense`. You can omit the argument if you don't care about it.",
      "cop_name": "Lint/UnusedBlockArgument",
      "corrected": false,
      "location": {
        "line": 20,
        "column": 25,
        "length": 7
      }
    }]
  }, {
    "path": "lib/mugatu/rubocop_runner.rb",
    "offenses": [{
      "severity": "warning",
      "message": "Useless assignment to variable - `output`.",
      "cop_name": "Lint/UselessAssignment",
      "corrected": null,
      "location": {
        "line": 19,
        "column": 7,
        "length": 6
      }
    }]
  }, {
    "path": "lib/mugatu/version.rb",
    "offenses": []
  }],
  "summary": {
    "offense_count": 6,
    "target_file_count": 7,
    "inspected_file_count": 7
  }
}

