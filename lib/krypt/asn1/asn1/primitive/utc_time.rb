module Krypt::Asn1
  class UtcTime < Primitive

    def self.default_tag
      UTC_TIME
    end

  end
end

