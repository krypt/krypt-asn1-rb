require_relative 'string_codec'

module Krypt::Asn1
  class GeneralString < Primitive
    include StringCodec

    def default_tag
      Der::Tag::GENERAL_STRING
    end
    
  end
end

