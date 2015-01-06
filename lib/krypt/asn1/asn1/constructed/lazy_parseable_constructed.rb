module Krypt::Asn1
  class Constructed
    class LazyParseableDer

      def initialize(der, codec)
        @der = der
        @codec = codec
      end

      def tag
        @der.tag
      end

      def length
        @der.length
      end

      def value
        @der.value
      end

      def parsed_value
        parse_value unless defined?(@parsed_value)
        @parsed_value
      end

      def encode_to(io)
        @der.encode_to(io)
      end

      private

      def parse_value
        @parsed_value = @codec.parse(@der.value)
        remove_instance_variable(:@codec)
      end

    end
  end
end
