module Mugatu
  module Configs
    class LinterConfig
      def initialize(root, config)
        @name       = config["name"]
        @executable = config["executable"]
        @arguments  = config["arguments"]
        @paths      = config["paths"]
        @exclude    = config["exclude"]
        @include    = config["include"]
        @root       = root
      end

      attr_reader :name

      def paths
        @paths || []
      end

      def exclude
        @exclude || []
      end

      def include
        @include || []
      end
    end
  end
end
