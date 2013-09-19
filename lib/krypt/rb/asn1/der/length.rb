require_relative 'cached_encoding'

module Krypt::Rb::Asn1
  class Der::Length
    include Der::CachedEncoding

    INDEFINITE_LENGTH_MASK = 0x80

    attr_reader :length

    def initialize(options)
      @length = options[:length]
      @indefinite = !!options[:indefinite]
      @encoding = options[:encoding]
    end

    def indefinite?; @indefinite; end

    private

    def encode
      @encoding = Der::LengthEncoder.encode(self)
    end

  end
end

