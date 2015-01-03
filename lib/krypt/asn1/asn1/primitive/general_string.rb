require_relative 'string_codec'

module Krypt::Asn1
  class GeneralString < Primitive
    include StringCodec

    def self.default_tag
      GENERAL_STRING
    end

  end
end

