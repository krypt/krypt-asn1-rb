# encoding: BINARY

module Krypt::Asn1::Rb
  module Asn1ObjectEncoder

    def encode_to(io)
      @tag.encode_to(io)
      @length.encode_to(io)
      io << @value
    end

    def encoding
      # String.new enforces BINARY encoding
      StringIO.new(String.new).tap do |io|
        encode_to(io)
      end.string
    end

  end
end

