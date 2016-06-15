module Mugatu
  module Cli
    class Options
      def initialize(argv, registry)
        @options = {}
        @argv = argv
        @ran = false
        @registry = registry
      end

      def options
        return @options if @ran

        parser.parse!(@argv)
        @ran = true

        @options
      end

      def files
        options

        @argv
      end

      private

      def parser
        @parser ||=
          OptionParser.new do |parser|
            parser.banner = "usage: #{$PROGRAM_NAME} [options] [files]"
            parser.separator ""
            parser.separator "options:"

            parser.on("--base REF", "Git ref of base commit") do |ref|
              @options[:ref] = ref
            end

            formatters = @registry.formatters.keys

            parser.on("-f FORMAT", "--format FORMAT", formatters, "Output format (#{formatters.join(", ")})") do |format|
              @options[:format] = format
            end

            parser.on("-c PATH", "--config PATH", String, "Path to config file") do |config_file|
              @options[:config] = config_file
            end

            parser.on("-h", "--help", "Show this message") do
              puts parser
              exit
            end

            parser.on("-v", "--version", "Print version") do
              puts Mugatu::VERSION
            end

            parser.separator ""
            parser.separator "in your project root, create a file called `.mugatu.yml`"
            parser.separator "with these contents:"
            parser.separator ""
            parser.separator "```"

            File.read(File.expand_path("../../../../.mugatu.yml", __FILE__)).each_line do |line|
              parser.separator line
            end

            parser.separator "```"
          end
      end
    end
  end
end
