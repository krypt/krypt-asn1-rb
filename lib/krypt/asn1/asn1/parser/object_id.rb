module Krypt::Asn1
  module Parser
    module ObjectId

      module_function

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

      private; module_function

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

    end
  end
end

