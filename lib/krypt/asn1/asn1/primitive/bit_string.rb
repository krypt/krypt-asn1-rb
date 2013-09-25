# encoding: BINARY

module Krypt::Asn1
  class BitString < Primitive

    def parse_value(bytes)
      @unused_bits = bytes[0].ord
      check_unused_bits
      bytes[1..-1]
    end

    def encode_value(value)
      check_unused_bits
      value.prepend(@unused_bits.chr)
    end

    def default_tag
      Asn1::BIT_STRING
    end

    def check_unused_bits
      if @unused_bits < 0 || @unused_bits > 7
        raise "Unused bits must be 0..7"
      end
    end

  end
end

