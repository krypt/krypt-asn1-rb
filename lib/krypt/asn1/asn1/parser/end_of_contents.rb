module Krypt::ASN1
  module Parser
    module EndOfContents

      module_function

      def parse_value(bytes)
        raise "END OF CONTENTS must not contain a value: #{bytes}" if bytes
        nil
      end

    end
  end
end

