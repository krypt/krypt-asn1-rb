module Krypt::Asn1
  class Der::Length

    INDEFINITE_LENGTH_MASK = 0x80

    attr_reader :length, :indefinite
    alias indefinite? indefinite

    def initialize(options)
      @length = options[:length]
      @indefinite = !!options[:indefinite]
      @encoding = options[:encoding]
    end

    def encoding
      Der::LengthEncoder.encode(self)
    end

    def encode_to(io)
      io << encoding
    end

  end
end

