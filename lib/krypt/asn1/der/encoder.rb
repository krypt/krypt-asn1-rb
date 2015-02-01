require_relative 'encoder/tag_encoder'
require_relative 'encoder/length_encoder'

module Krypt::Asn1
  module Der::Encoder

    module_function

    def to_der(der)
      io = StringIO.new(String.new)
      encode_to(io, der)
      io.string
    end

    def encode_to(io, der)
      io << der.tag.encoding
      io << der.length.encoding
      io << der.value
    end

    def encode_tag(tag)
      Der::TagEncoder.encode(tag)
    end

    def encode_length(length)
      Der::LengthEncoder.encode(length)
    end

  end
end

