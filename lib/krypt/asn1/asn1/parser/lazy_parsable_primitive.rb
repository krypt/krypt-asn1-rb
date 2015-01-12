module Krypt::Asn1
  module Parser
    class LazyParsablePrimitive

      def initialize(object, der)
        @der = der
        @object = object
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
        @parsed_value = Parser.parse_value(@object, @der.value)
      end

    end
  end
end
