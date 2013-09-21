require_relative 'string_codec'

module Krypt::Asn1
  class Ia5String < Primitive
    include StringCodec

    def default_tag
      Der::Tag::IA5_STRING
    end
    
  end
end

