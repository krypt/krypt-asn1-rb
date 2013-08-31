# encoding: BINARY

require_relative 'encoder/tag_encoder'
require_relative 'encoder/length_encoder'

module Krypt::Rb::Asn1
  module Der::Encoder

    def encode_to(io)
      @tag.encode_to(io)
      @length.encode_to(io)
      io << @value
    end

  end
end

