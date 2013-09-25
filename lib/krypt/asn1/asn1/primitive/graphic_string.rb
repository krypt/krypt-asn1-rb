require_relative 'string_codec'

module Krypt::Asn1
  class GraphicString < Primitive
    include StringCodec

    def default_tag
      GRAPHIC_STRING
    end
    
  end
end

