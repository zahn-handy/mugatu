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
      "#{file}:#{line} #{severity}\n#{name}: #{message}"
    end
  end
end
