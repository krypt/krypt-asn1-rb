# encoding: BINARY

module Krypt::Asn1
  module IOEncodable

    def encoding
      # String.new enforces BINARY encoding
      StringIO.new(String.new).tap do |io|
        encode_to(io)
      end.string
    end
    alias :to_der :encoding

  end
end
