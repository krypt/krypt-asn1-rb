require_relative 'string_codec'

module Krypt::Asn1
  class PrintableString < Primitive
    include StringCodec

    def default_tag
      Der::Tag::PRINTABLE_STRING
    end
    
  end
end

