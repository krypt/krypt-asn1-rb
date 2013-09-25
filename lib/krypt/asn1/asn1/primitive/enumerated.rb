require_relative 'integer_codec'

module Krypt::Asn1
  class Enumerated < Primitive
    include IntegerCodec

    def default_tag
      ENUMERATED
    end

  end
end

