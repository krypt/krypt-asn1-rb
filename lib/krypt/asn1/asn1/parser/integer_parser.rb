module Krypt::ASN1
  module Parser
    module IntegerParser

      module_function

      def parse_value(bytes)
        if (bytes[0].ord & 0x80) == 0x80
          negative(bytes)
        else
          positive(bytes)
        end
      end

      private; module_function

      def negative(bytes)
        -positive(Helpers::Integer.twos_complement(bytes))
      end

      def positive(bytes)
        bytes.unpack('H*')[0].to_i(16)
      end

    end
  end
end

