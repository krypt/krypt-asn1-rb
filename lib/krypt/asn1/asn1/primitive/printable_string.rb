module Krypt::Asn1
  class PrintableString < Primitive

    def self.default_tag
      PRINTABLE_STRING
    end

  end
end

