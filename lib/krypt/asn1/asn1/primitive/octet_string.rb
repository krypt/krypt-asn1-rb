module Krypt::Asn1
  class OctetString < Primitive

    def self.default_tag
      OCTET_STRING
    end

  end
end

