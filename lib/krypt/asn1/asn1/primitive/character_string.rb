require_relative 'string_codec'

module Krypt::Asn1
  class CharacterString < Primitive
    include StringCodec

    def default_tag
      Der::Tag::CHARACTER_STRING
    end

  end
end

