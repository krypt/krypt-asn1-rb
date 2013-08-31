# encoding: BINARY

module Krypt::Rb::Asn1
  module Der::LengthEncoder

    module_function

    def encode(length)
      return Der::Length::INDEFINITE_LENGTH_MASK.chr if length.indefinite?

      len = length.length

      if len <= 127
        len.chr
      else
        complex_length(len)
      end
    end

    private; module_function

    def complex_length(len)
      bytes = length_bytes(len)
      # TODO raise error if bytes.size too large
      bytes.unshift(bytes.size | Der::Length::INDEFINITE_LENGTH_MASK)
      bytes.pack('C*')
    end

    def length_bytes(len)
      return [0] if len == 0

      [].tap do |ary|
        while len > 0
          ary << (len & 0xff)
          len >>= 8
        end
      end
    end

  end
end

