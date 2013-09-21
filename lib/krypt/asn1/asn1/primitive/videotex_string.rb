require_relative 'string_codec'

module Krypt::Asn1
  class VideotexString < Primitive
    include StringCodec

    def default_tag
      Der::Tag::VIDEOTEX_STRING
    end
    
  end
end

