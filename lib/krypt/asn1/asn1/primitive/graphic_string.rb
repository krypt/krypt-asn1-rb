require_relative 'string_codec'

module Krypt::Asn1
  class GraphicString < Primitive
    include StringCodec

    def default_tag
      Asn1::GRAPHIC_STRING
    end
    
  end
end

