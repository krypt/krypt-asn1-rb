require_relative 'string_codec'

module Krypt::Asn1
  class VideotexString < Primitive
    include StringCodec

    def self.default_tag
      VIDEOTEX_STRING
    end

  end
end

