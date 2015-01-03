require_relative 'string_codec'

module Krypt::Asn1
  class BmpString < Primitive
    include StringCodec

    def self.default_tag
      BMP_STRING
    end

  end
end

