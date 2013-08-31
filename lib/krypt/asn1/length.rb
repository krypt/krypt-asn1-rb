require_relative 'encoder'

module Krypt::Asn1::Rb
  class Length
    include IOEncodable

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
      @encoding = LengthEncoder.encode(self)
    end

  end
end

 
