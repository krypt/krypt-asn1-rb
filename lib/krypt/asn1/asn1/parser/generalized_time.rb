require 'time'

module Krypt::Asn1
  module Parser
    module GeneralizedTime

      module_function

      def parse_value(bytes)
        DateTime.strptime(value, "%Y%m%d%H%M%S%Z")
      end

    end
  end
end

