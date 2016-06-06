module Mugatu
  class DiffParser
    FileDiff = Struct.new(:header, :sections)
    SectionDiff = Struct.new(:context, :diff)

    def initialize(colored_git_diff_output)
      @diff = colored_git_diff_output
    end

    def call
      result = []
      index = 0
      lines = @diff.split(/\n/)

      current_state = :file
      current_file = FileDiff.new([], [])
      current_section = SectionDiff.new(nil, [])

      loop do
        if lines[index].nil?
          break
        end

        if lines[index] =~ /^\s*$/
          puts lines[index].inspect
          index += 1
        end

        case current_state
        when :file
          if lines[index] =~ /^\e\[1m/
            current_file.header.push(lines[index])
            index += 1
          else
            result.push(current_file)
            current_state = :context
          end
        when :context
          if lines[index] =~ /^\e\[36m/
            current_section.context = lines[index]
            index += 1
          else
            current_file.sections.push(current_section)
            current_state = :diff
          end
        when :diff
          if lines[index] =~ /^\e\[32m/ || lines[index] =~ /^\e\[31m/
            current_section.diff.push(lines[index])
            index += 1
          elsif lines[index] =~ /^\e\[36m/
            current_section = SectionDiff.new(nil, [])
            current_state = :context
          else
            current_file = FileDiff.new([], [])
            current_state = :file
          end
        end
      end

      result
    end
  end
end
