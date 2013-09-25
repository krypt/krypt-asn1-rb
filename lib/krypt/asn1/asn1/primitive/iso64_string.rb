require_relative 'string_codec'

module Krypt::Asn1
  class Iso64String < Primitive
    include StringCodec

    def default_tag
      ISO64_STRING
    end
    
  end
end

