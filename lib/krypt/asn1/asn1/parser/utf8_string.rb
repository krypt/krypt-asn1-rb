module Krypt::ASN1
  module Parser
    module Utf8String

      module_function

      def parse_value(bytes)
        bytes.dup.force_encoding(Encoding::UTF_8)
      end

    end
  end
end

