module Krypt::Asn1::Rb
  module IOEncodable

    def encoding
      @encoding || encode
    end

    def encode_to(io)
      io << encoding
    end

  end
end
