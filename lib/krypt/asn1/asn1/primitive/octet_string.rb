require_relative 'string_codec'

module Krypt::Asn1
  class OctetString < Primitive
    include StringCodec

    def default_tag
      OCTET_STRING
    end
    
  end
end

