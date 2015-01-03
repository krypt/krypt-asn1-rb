# encoding: BINARY

module Krypt::Asn1
  class Boolean < Primitive

    def self.default_tag
      BOOLEAN
    end

    def parse_value(bytes)
      unless bytes.size == 1
        raise "Invalid BOOLEAN value: #{bytes}"
      end

      bytes != "\x00"
    end

    def encode_value(value)
      value ? "\xff" : "\x00"
    end

  end
end

