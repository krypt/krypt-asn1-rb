require_relative 'string_codec'

module Krypt::Asn1
  class CharacterString < Primitive
    include StringCodec

    def default_tag
      Asn1::CHARACTER_STRING
    end

  end
end

