module Krypt::ASN1
  module Parser
   module BitString

     module_function

      def parse_value(bytes)
        unused_bits = bytes[0].ord
        Krypt::ASN1::BitString::Value.new(bytes[1..-1], unused_bits)
      end

   end
  end
end

