require_relative 'string_codec'

module Krypt::Asn1
  class UniversalString < Primitive
    include StringCodec

    def default_tag
      Asn1::UNIVERSAL_STRING
    end
    
  end
end

