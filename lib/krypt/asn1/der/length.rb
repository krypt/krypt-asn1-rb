module Krypt::Asn1
  class Der::Length

    INDEFINITE_LENGTH_MASK = 0x80

    attr_reader :length, :indefinite
    alias_method :indefinite?, :indefinite

    def initialize(options)
      @indefinite = !!options[:indefinite]
      @length = options[:length]
      @encoding = options[:encoding]
    end

    def encoding
      @encoding ||= Der::Encoder.encode_length(self)
    end

  end
end

