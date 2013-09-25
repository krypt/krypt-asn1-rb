require_relative 'string_codec'

module Krypt::Asn1
  class Ia5String < Primitive
    include StringCodec

    def default_tag
      Asn1::IA5_STRING
    end
    
  end
end

