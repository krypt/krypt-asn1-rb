require 'time'

module Krypt::ASN1
  module Encoder
    module GeneralizedTime

      module_function

      def encode_value(object, value)
        value.to_time.utc.strftime("%Y%m%d%H%M%SZ")
      end

    end
  end
end

