require 'time'

module Krypt::Asn1
  class UtcTime < Primitive

    def parse_value(bytes)
      DateTime.strptime(value, "%y%m%d%H%M%SZ") do |y|
        y < 50 ? y + 2000 : y + 1900
      end
    end

    def encode_value(value)
      value.to_time.utc.strftime("%Y%m%d%H%M%SZ")
    end

    def default_tag
      UTC_TIME
    end

  end
end

