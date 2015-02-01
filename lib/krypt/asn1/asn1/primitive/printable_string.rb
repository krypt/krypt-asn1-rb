module Krypt::Asn1
  class PrintableString < Primitive

    def default_tag
      PRINTABLE_STRING
    end

  end
end

