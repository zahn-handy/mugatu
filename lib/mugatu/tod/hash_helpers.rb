module Mugatu
  module Tod
    module HashHelpers
      def self.dig(hash, *keys)
        head, *tail = keys

        if hash[head].is_a?(Hash)
          dig(hash[head], *tail)
        else
          hash[head]
        end
      end
    end
  end
end
