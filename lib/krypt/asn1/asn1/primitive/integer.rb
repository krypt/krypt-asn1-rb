require_relative 'integer_codec'

module Krypt::Asn1
  class Integer < Primitive
    include IntegerCodec

    def default_tag
      Der::Tag::INTEGER
    end

  end
end

