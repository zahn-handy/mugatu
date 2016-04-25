module Mugatu
  class Problem
    def initialize(linter:, name:, message:, severity:, file:, line:, **misc)
      @linter   = linter
      @name     = name
      @message  = message
      @severity = severity
      @file     = file
      @line     = line
      @misc     = misc
    end

    attr_reader :linter, :name, :message, :severity
    attr_reader :file, :line, :misc

    def to_s
      "#{name}: #{message}\n#{severity}"
    end
  end
end
