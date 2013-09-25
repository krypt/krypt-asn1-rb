module Krypt::Asn1
  class ObjectId < Primitive

    def parse_value(bytes)
      [].tap do |oid|
        n, off = parse_int(bytes, 0)
        set_first(n, oid)

        loop do
          n, off = parse_int(bytes, off)
          break unless n
          oid << n
        end
      end
    end

    def encode_value(value)
      String.new.tap do |buf|
        encode_int(buf, 40 * value[0] + value[1])
        value.slice(2..-1).each { |n| encode_int(buf, n) }
      end
    end

    def default_tag
      Asn1::OBJECT_ID
    end

    private

    def parse_int(bytes, off)
      num = 0
      len = bytes.size
      return nil if off >= len

      update = lambda do |b|
        num <<= 7
        num |= b.ord & 0x7f
        off += 1
      end

      while ((b = bytes[off].ord) & 0x80) == 0x80
        update.call(b)
        raise "Invalid OBJECT IDENTIFIER encoding" if off >= len
      end
      update.call(b)
      return num, off
    end

    def set_first(n, oid)
      if n < 80
        oid[0] = n / 40
        oid[1] = n % 40
      else
        oid[0] = 2
        oid[1] = n - 80
      end
    end

    def encode_int(buf, n)
      tmp = (n & 0x7f).chr
      n >>= 7

      while n > 0
        byte = n & 0x7f
        byte |= Der::Length::INDEFINITE_LENGTH_MASK
        tmp.prepend(byte.chr)
        n >>= 7
      end
      buf << tmp
    end

  end
end

