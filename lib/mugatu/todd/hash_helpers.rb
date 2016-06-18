module Mugatu
  module Todd
    module HashHelpers
      def self.dig(hash, *keys)
        head, *tail = keys

        if hash[head].is_a?(Hash)
          dig(hash[head], *tail)
        else
          hash[head]
        end
      end

      def self.symbolize_keys(obj)
        case obj
        when Hash
          symbolize_keys_shallow(obj)
        when Array
          obj.map do |o|
            symbolize_keys(o)
          end
        else
          obj
        end
      end

      def self.symbolize_keys_shallow(hash)
        hash.each_with_object({}) do |(key, value), memo|
          new_key =
            if key.is_a?(String)
              key.to_sym
            else
              key
            end

          memo[new_key] = symbolize_keys(value)
        end
      end
    end
  end
end
