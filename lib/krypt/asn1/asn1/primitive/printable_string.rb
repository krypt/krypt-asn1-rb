require_relative 'string_codec'

module Krypt::Asn1
  class PrintableString < Primitive
    include StringCodec

    def self.default_tag
      PRINTABLE_STRING
    end

  end
end

