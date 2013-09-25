require_relative 'string_codec'

module Krypt::Asn1
  class UniversalString < Primitive
    include StringCodec

    def default_tag
      UNIVERSAL_STRING
    end
    
  end
end

