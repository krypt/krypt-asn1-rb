module Krypt::Asn1
  module Encoder
    module StringEncoder

      module_function

      def encode_value(object, value)
        value.encoding == Encoding::BINARY ? value : encode(value)
      end

      private; module_function

      def encode(value)
        if value.encoding.ascii_compatible?
          value.dup.force_encoding(Encoding::BINARY)
        else
          value.encode(Encoding::BINARY)
        end
      end

    end
  end
end

