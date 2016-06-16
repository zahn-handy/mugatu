module Mugatu
  module Todd
    class System
      def self.call(*args)
        Open3.capture2(*args).first
      end
    end
  end
end
