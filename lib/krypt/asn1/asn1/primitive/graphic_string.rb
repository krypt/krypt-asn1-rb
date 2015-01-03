require_relative 'string_codec'

module Krypt::Asn1
  class GraphicString < Primitive
    include StringCodec

    def self.default_tag
      GRAPHIC_STRING
    end

  end
end

