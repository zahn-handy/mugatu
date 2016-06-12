module Mugatu
  module Cli
    class Options
    end

    class Run
      def self.parse(argv)
        instance = new({}, argv)
        options = instance.options
        puts options
      end

      OUTPUT_FORMATS = %i(pretty json).freeze

      def initialize(options, argv)
        @options = options
        @argv = argv
      end

      def options
        parser.parse!(@argv.dup)

        @options
      end

      private

      def parser
        @parser ||=
          OptionParser.new do |parser|
            parser.banner = "usage: #{$0} [options] [files]"
            parser.separator ""
            parser.separator "options:"

            parser.on("-f [FORMAT]", "--format [FORMAT]", OUTPUT_FORMATS, "Output format (#{OUTPUT_FORMATS.join(", ")})") do |format|
              @options[:format] = format
            end

            parser.on("-c PATH", "--config PATH", String, "Path to config file") do |config_file|
              @options[:config] = config_file
            end

            parser.on_tail("-h", "--help", "Show this message") do
              puts parser
              exit
            end

            parser.on_tail("-v", "--version", "Print version") do
              puts Mugatu::VERSION
            end

            parser.define_tail ""
            parser.define_tail "in your project root, create a file called `.mugatu.yml`"
            parser.define_tail "with these contents:"
            parser.define_tail ""
            parser.define_tail "```"

            File.read(File.expand_path("../../../../.mugatu.yml", __FILE__)).each_line do |line|
              parser.define_tail line
            end

            parser.define_tail "```"
          end
      end
    end
  end
end
