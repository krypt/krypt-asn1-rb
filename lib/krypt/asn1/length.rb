# encoding: BINARY

require_relative 'io_encodable'

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
      if @indefinite
        INDEFINITE_LENGTH_MASK.chr
      elsif @length <= 127
        @length.chr
      else
        complex_length
      end
    end

    def complex_length
      bytes = len_bytes
      # TODO raise error if bytes.size too large
      bytes.unshift(bytes.size | INDEFINITE_LENGTH_MASK)
      bytes.pack('C*')
    end

    def len_bytes
      return [0] if @length == 0

      [].tap do |ary|
        tmp = @length
        while tmp > 0
          ary << (tmp & 0xff)
          tmp >>= 8
        end
      end
    end

  end
end

 
