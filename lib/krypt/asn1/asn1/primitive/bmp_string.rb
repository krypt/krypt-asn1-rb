module Krypt::ASN1
  class BmpString < Primitive

    def self.default_tag
      BMP_STRING
    end

  end
end

