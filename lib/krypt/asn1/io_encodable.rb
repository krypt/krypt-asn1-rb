# encoding: BINARY

module Krypt::Asn1
  module IOEncodable

    def encoding
      # String.new enforces BINARY encoding
      io = StringIO.new(String.new)
      encode_to(io)
      io.string
    end
    alias :to_der :encoding

  end
end
