require_relative 'string_codec'

module Krypt::Asn1
  class UniversalString < Primitive
    include StringCodec

    def default_tag
      Der::Tag::UNIVERSAL_STRING
    end
    
  end
end

