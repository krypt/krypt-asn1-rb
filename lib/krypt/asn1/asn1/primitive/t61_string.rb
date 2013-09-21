require_relative 'string_codec'

module Krypt::Asn1
  class T61String < Primitive
    include StringCodec

    def default_tag
      Der::Tag::T61_STRING
    end
    
  end
end

