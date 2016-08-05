module Mugatu
  module Formatters
    class Pretty
      def self.identifier
        :pretty
      end

      class ProblemPresenter
        def initialize(problem)
          @problem = problem
        end

        def to_s
          "#{Rainbow(@problem.file).cyan}:#{@problem.line} #{@problem.linter} #{@problem.severity}\n" +
          "#{@problem.name}: #{@problem.message}"
        end
      end

      def initialize(files:, start_time:)
        @problems = []
        @files = files
      end

      def start
      end

      def done
        if @problems.any?
          puts @problems.map(&:to_s).join("\n\n")
          puts
        end

        puts "Searched #{@files.count} files. Found #{@problems.count} problems."
      end

      def found(problem)
        @problems.push(ProblemPresenter.new(problem))
      end
    end
  end
end
