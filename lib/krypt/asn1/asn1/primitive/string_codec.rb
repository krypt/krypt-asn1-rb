module Krypt::Asn1
  module StringCodec

    def parse_value(bytes)
      bytes.dup
    end

    def encode_value(value)
      enc = value.encoding
      if enc == Encoding::BINARY
        enc.dup
      else
        encode(value)
      end
    end

    private

    def encode(value)
      if value.encoding.ascii_compatible?
        value.dup.force_encoding(Encoding::BINARY)
      else
        value.encode(Encoding::BINARY)
      end
    end

  end
end

