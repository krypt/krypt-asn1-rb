# encoding: BINARY

module Krypt::Asn1
  module Parser
    module Boolean

      module_function

      def parse_value(bytes)
        unless bytes.size == 1
          raise "Invalid BOOLEAN value: #{bytes}"
        end

        bytes != "\x00"
      end

    end
  end
end

