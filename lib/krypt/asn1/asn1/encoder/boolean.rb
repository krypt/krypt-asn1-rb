module Krypt::ASN1
  module Encoder
    module Boolean

      module_function

      def encode_value(object, value)
        value ? "\xff" : "\x00"
      end

    end
  end
end

