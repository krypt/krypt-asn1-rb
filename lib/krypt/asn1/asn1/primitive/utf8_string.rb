module Krypt::ASN1
  class Utf8String < Primitive

    def self.default_tag
      UTF8_STRING
    end

  end
end

