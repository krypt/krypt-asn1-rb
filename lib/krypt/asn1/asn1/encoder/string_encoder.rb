module Krypt::Asn1
  module Encoder
    module StringEncoder

      module_function

      def encode_value(object, value)
        enc = value.encoding
        if enc == Encoding::BINARY
          value
        else
          encode(value, enc)
        end
      end

      private; module_function

      def encode(value, enc)
        if enc.ascii_compatible?
          value.dup.force_encoding(Encoding::BINARY)
        else
          value.encode(Encoding::BINARY)
        end
      end

    end
  end
end

