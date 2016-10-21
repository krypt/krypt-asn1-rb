module Krypt::Asn1
  module Der::LengthParser

    module_function

    def parse_length(io)
      b = io.readbyte
      mask = Der::Length::INDEFINITE_LENGTH_MASK

      if b == mask
        Der::Length.new(indefinite: true, encoding: b.chr)
      elsif (b & mask) == mask
        complex_definite_length(b, io)
      else
        Der::Length.new(length: b, encoding: b.chr)
      end
    end

    private; module_function

    def complex_definite_length(b, io)
      if b == 0xff
        raise "Initial octet of complex definite length shall not be 0xFF"
      end

      len = 0
      num_bytes = b & 0x7f
      buf = b.chr

      num_bytes.times do
        b = io.readbyte
        len <<= 8
        len |= b
        buf << b
      end

      Der::Length.new(length: len, encoding: buf)
    end

  end
end
