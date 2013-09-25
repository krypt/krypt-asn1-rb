require_relative 'string_codec'

module Krypt::Asn1
  class OctetString < Primitive
    include StringCodec

    def default_tag
      Asn1::OCTET_STRING
    end
    
  end
end

