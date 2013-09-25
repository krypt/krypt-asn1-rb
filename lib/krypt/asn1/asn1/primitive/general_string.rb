require_relative 'string_codec'

module Krypt::Asn1
  class GeneralString < Primitive
    include StringCodec

    def default_tag
      Asn1::GENERAL_STRING
    end
    
  end
end

