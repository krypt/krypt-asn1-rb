module Krypt::Asn1
  module Encoder
    module ObjectId

      module_function

      def encode_value(object, value)
        buf = String.new
        encode_int(buf, 40 * value[0] + value[1])
        value.slice(2..-1).each { |n| encode_int(buf, n) }
        buf
      end

      private; module_function

      def encode_int(buf, n)
        tmp = (n & 0x7f).chr
        n >>= 7

        while n > 0
          byte = n & 0x7f
          byte |= Der::Length::INDEFINITE_LENGTH_MASK
          tmp.prepend(byte.chr)
          n >>= 7
        end

        buf << tmp
      end

    end
  end
end

