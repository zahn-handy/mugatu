module Mugatu
  class DiffParser
    FileDiff = Struct.new(:header, :sections)
    SectionDiff = Struct.new(:context, :diff)
    Addition = Struct.new(:filename, :lines)

    BLANK_LINE_REGEX = /^\A*\z/.freeze
    BOLD_LINE_REGEX  = /^\e\[1m/.freeze
    CYAN_LINE_REGEX  = /^\e\[36m/.freeze
    RED_OR_GREEN_LINE_REGEX = /^\e\[3[12]m/.freeze
    HEADER_FILENAME_REGEX =
      /
        ^
        \e\[1m       # bold text escape sequence
        \+\+\+\sb\/  # `+++ b` and a forward slash
        (.*)         # this is the filename part
        \e\[m        # reset text escape sequence
        $
      /x
    CONTEXT_STRING_REGEX =
      /
        ^
        \e\[36m@@         # starts with escape sequence and double ats
        \s+
        ([0-9,\+\-\s]+)  # line number part
        \s+
        @@               # that's closed by double ats
        .*               # line context text
        \e\[m
        $
      /x

    # http://stackoverflow.com/questions/2529441/
    CONTEXT_NUMBERS_REGEX =
      /
        ^
        -
        (?<minus_start>\d+)
        (?:                    # optional non-capturing group
          ,                    # two numbers are separated by a comma
          (?<minus_count>\d+)
        )?                     # the ? denotes an optional group
        \s+                    # separated by space
        \+
        (?<plus_start>\d+)
        (?:                    # optional non-capturing group
          ,                    # two numbers are separated by a comma
          (?<plus_count>\d+)
        )?                     # the ? denotes an optional group
        $
      /x

    def initialize(colored_git_diff_output)
      @diff = colored_git_diff_output
      @lines = @diff.split(/\n/)
      @result = []

      compute_result!
      compute_additions!
    end

    attr_reader :result
    attr_reader :additions

    private

    def compute_additions!
      @additions =
        result.flat_map do |file_diff|
          filename = changed_filename(file_diff.header.last)

          if filename.nil?
            next
          end

          file_diff.sections.flat_map do |section_diff|
            context_string = parse_context(section_diff.context)

            if context_string.nil?
              puts "😭"
              next
            end

            context = context_lines(context_string)

            section_diff.diff.map do |line|
              is_addition =
                if line =~ /\e\[32m+/
                  true
                else
                  false
                end

              {
                filename: filename,
                context: context,
                is_addition: is_addition,
                line: line
              }
            end
          end
        end
        .compact
    end

    def context_lines(context_string)
      match = CONTEXT_NUMBERS_REGEX.match(context_string)

      if match.nil?
        {
          minus_start: 0,
          minus_count: 0,
          plus_start: 0,
          plus_count: 0
        }
      else
        hash_keys = match.names.map(&:to_sym)
        hash_vals = match.captures.map { |v| v.nil? ? nil : v.to_i }
        result = hash_keys.zip(hash_vals).to_h

        result[:minus_count] ||= 1
        result[:plus_count] ||= 1

        result
      end
    end

    def parse_context(context)
      match = CONTEXT_STRING_REGEX.match(context)

      if match.nil?
        nil
      else
        match[1]
      end
    end


    def changed_filename(last_header_line)
      filename_match = HEADER_FILENAME_REGEX.match(last_header_line)

      if filename_match.nil?
        nil
      else
        filename_match[1]
      end
    end

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
