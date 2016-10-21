module Krypt::Asn1
  module Encoder
    module IntegerEncoder

      module_function

      def encode_value(object, value)
        value < 0 ? negative(value) : positive(value)
      end

      private; module_function

      def negative(value)
        bytes = unsigned(value.abs)
        first = bytes[0].ord
        pad = false

        if first > 0x80
          pad = true
        elsif first == 0x80
          pad = rest_not_zero?(bytes)
        end

        Helpers::Integer.twos_complement!(bytes)
        bytes.prepend("\xff") if pad
        bytes
      end

      def positive(value)
        bytes = unsigned(value)
        first = bytes[0].ord
        if (bytes[0].ord & 0x80) == 0x80
          bytes.prepend("\x00")
        end
        bytes
      end

      def unsigned(value)
        hex = value.to_s(16)
        if (hex.size % 2) == 1
          hex = hex.prepend("0")
        end
        [hex].pack('H*')
      end

      def rest_not_zero?(bytes)
        return false if bytes.size == 1
        bytes[1..-1].each_byte.any? { |b| b > 0 }
      end

    end
  end
end

