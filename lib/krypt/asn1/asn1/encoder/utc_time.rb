require 'time'

module Krypt::Asn1
  module Encoder
    module UtcTime

      module_function

      def encode_value(object, value)
        value.to_time.utc.strftime("%Y%m%d%H%M%SZ")
      end

    end
  end
end

