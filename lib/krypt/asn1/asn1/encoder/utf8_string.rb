module Krypt::ASN1
  module Encoder
    module Utf8String

      module_function

      def encode_value(object, value)
        if value.encoding.ascii_compatible?
          value.dup.force_encoding(Encoding::UTF_8)
        else
          value.encode(Encoding::UTF_8)
        end
      end

    end
  end
end

