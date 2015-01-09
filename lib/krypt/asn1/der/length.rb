module Krypt::Asn1
  class Der::Length

    INDEFINITE_LENGTH_MASK = 0x80

    attr_reader :length, :indefinite
    alias indefinite? indefinite

    def initialize(options)
      @indefinite = !!options[:indefinite]
      @length = options[:length] unless @indefinite
      @encoding = options[:encoding]
    end

    def encoding
      @encoding ||= Der::LengthEncoder.encode(self)
    end

    def encode_to(io)
      io << encoding
    end

  end
end

