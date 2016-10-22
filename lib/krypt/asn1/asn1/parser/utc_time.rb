require 'time'

module Krypt::ASN1
  module Parser
    module UtcTime

      module_function

      def parse_value(bytes)
        DateTime.strptime(bytes, "%y%m%d%H%M%SZ") do |y|
          y < 50 ? y + 2000 : y + 1900
        end
      end

    end
  end
end

