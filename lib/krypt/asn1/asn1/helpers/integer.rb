module Krypt::Asn1
  module Helpers
    module Integer

      module_function

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
end
