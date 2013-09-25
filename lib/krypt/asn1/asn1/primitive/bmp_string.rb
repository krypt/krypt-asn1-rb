require_relative 'string_codec'

module Krypt::Asn1
  class BmpString < Primitive
    include StringCodec

    def default_tag
      BMP_STRING
    end
    
  end
end

