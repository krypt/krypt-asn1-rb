require_relative 'string_codec'

module Krypt::Asn1
  class NumericString < Primitive
    include StringCodec

    def default_tag
      Asn1::NUMERIC_STRING
    end
    
  end
end

