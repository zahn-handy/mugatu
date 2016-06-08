module Mugatu
  class DiffParser
    FileDiff = Struct.new(:header, :sections)
    SectionDiff = Struct.new(:context, :diff)
    Addition = Struct.new(:filename, :lines)

    BLANK_LINE_REGEX = /^\A*\z/.freeze
    BOLD_LINE_REGEX  = /^\e\[1m/.freeze
    CYAN_LINE_REGEX  = /^\e\[36m/.freeze
    RED_OR_GREEN_LINE_REGEX = /^\e\[3[12]m/.freeze

    def initialize(colored_git_diff_output)
      @diff = colored_git_diff_output
      @lines = @diff.split(/\n/)
      @result = []

      compute_result!
    end

    attr_reader :result

    private

    def compute_result!
      @index = 0
      @current_state = :file

      loop do
        if @lines[@index].nil?
          break
        end

        if @lines[@index] =~ BLANK_LINE_REGEX
          @index += 1
        end

        case @current_state
        when :file
          if @lines[@index] =~ BOLD_LINE_REGEX
            if @current_file.nil?
              @current_file = new_file_diff
              @result.push(@current_file)
            end

            @current_file.header.push(@lines[@index])
            @index += 1
          else
            @current_state = :context
          end
        when :context
          if @lines[@index] =~ CYAN_LINE_REGEX
            if @current_section.nil?
              @current_section = new_section_diff
              @current_file.sections.push(@current_section)
            end

            @current_section.context = @lines[@index]
            @index += 1
          else
            @current_state = :diff
          end
        when :diff
          if @lines[@index] =~ RED_OR_GREEN_LINE_REGEX
            @current_section.diff.push(@lines[@index])
            @index += 1
          elsif @lines[@index] =~ CYAN_LINE_REGEX
            @current_section = nil
            @current_state = :context
          else
            @current_file = nil
            @current_section = nil
            @current_state = :file
          end
        end
      end
    end

    def new_file_diff
      FileDiff.new([], [])
    end

    def new_section_diff
      SectionDiff.new(nil, [])
    end
  end
end
