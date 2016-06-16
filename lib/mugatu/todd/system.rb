module Mugatu
  module Todd
    class System
      def self.call(*args)
        non_nil_args = args.compact
        Open3.capture2(*non_nil_args).first
      end
    end
  end
end
