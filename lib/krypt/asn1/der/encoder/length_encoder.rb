# encoding: BINARY

module Krypt::Asn1
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
      # TODO raise error if bytes.size too large
      length_bytes(len).pack('C*')
    end

    def length_bytes(len)
      return [0] if len == 0
      num_bytes = bytelen(len) | Der::Length::INDEFINITE_LENGTH_MASK

      [num_bytes].tap do |ary|
        while len > 0
          ary << (len & 0xff)
          len >>= 8
        end
      end
    end

    def bytelen(value)
      return 1 if value == 0
      (Math.log2(value) / 8).floor + 1
    end

  end
end

