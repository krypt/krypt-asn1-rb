require_relative 'string_codec'

module Krypt::Asn1
  class VideotexString < Primitive
    include StringCodec

    def default_tag
      Asn1::VIDEOTEX_STRING
    end
    
  end
end

