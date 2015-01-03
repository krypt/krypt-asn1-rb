require_relative 'string_codec'

module Krypt::Asn1
  class Ia5String < Primitive
    include StringCodec

    def self.default_tag
      IA5_STRING
    end

  end
end

