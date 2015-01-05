module Krypt::Asn1
  module Der::CachedEncoding

    def encoding
      @encoding = encode unless @encoding
      @encoding.dup
    end

    def encode_to(io)
      io << encoding
    end

  end
end
