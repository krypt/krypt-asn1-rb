# encoding: BINARY

module Krypt::Asn1
  module IntegerCodec

    def parse_value(bytes)
      if (bytes[0].ord & 0x80) == 0x80
        parse_negative(bytes)
      else
        parse_positive(bytes)
      end
    end

    def encode_value(value)
      if value < 0
        encode_negative(value)
      else
        encode_positive(value)
      end
    end

    private

    def parse_negative(bytes)
      -parse_positive(twos_complement(bytes))
    end

    def parse_positive(bytes)
      bytes.unpack('H*')[0].to_i(16)
    end

    def encode_negative(value)
      bytes = encode_unsigned(value.abs)
      first = bytes[0].ord
      pad = false

      if first > 0x80
        pad = true
      elsif first == 0x80
        pad = rest_not_zero?(bytes)
      end

      twos_complement!(bytes)
      bytes.prepend("\xff") if pad
      bytes
    end

    def rest_not_zero?(bytes)
      return false if bytes.size == 1
      bytes[1..-1].each_byte.any? { |b| b > 0 }
    end

    def encode_positive(value)
      bytes = encode_unsigned(value)
      first = bytes[0].ord
      if (bytes[0].ord & 0x80) == 0x80
        bytes.prepend("\x00")
      end
      bytes
    end

    def encode_unsigned(value)
      hex = value.to_s(16)
      if (hex.size % 2) == 1
        hex = hex.prepend("0")
      end
      [hex].pack('H*')
    end

    def twos_complement(bytes)
      bytes.dup.tap { |ret| twos_complement!(ret) }
    end

    def twos_complement!(bytes)
      i = bytes.size - 1 # start at the end

      while (b = bytes[i]) == "\x00" # 0x00 bytes stay 0x00 (due to carry)
        i -= 1
      end

      bytes.setbyte(i, (b.ord ^ 0xff) + 1) # last non-zero byte is negated and incremented
      i -= 1

      while i >= 0
        bytes.setbyte(i, (bytes[i].ord ^ 0xff)) # remaining leading bytes are just negated
        i -= 1
      end
    end

  end
end

