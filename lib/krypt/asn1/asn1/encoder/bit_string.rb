module Krypt::ASN1
  module Encoder
    module BitString

      module_function

      def encode_value(object, value)
        unused_bits = object.unused_bits
        check_unused_bits(unused_bits)
        value.value.prepend(unused_bits.chr)
      end

      private; module_function

      def check_unused_bits(unused_bits)
        if unused_bits < 0 || unused_bits > 7
          raise "Unused bits must be 0..7"
        end
      end

    end
  end
end

