module Krypt::ASN1
  module Parser
    module Null

      module_function

      def parse_value(bytes)
        raise "NULL must not contain a value: #{bytes}" if bytes
        nil
      end

    end
  end
end

