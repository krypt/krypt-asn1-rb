# encoding: BINARY

module Krypt::Asn1
  class Boolean < Primitive

    def parse_value(bytes)
      unless bytes.size == 1
        raise "Invalid BOOLEAN value: #{bytes}"
      end 

      return false if bytes == "\x00" 
      true
    end

    def encode_value(value)
      value ? "\xff" : "\x00"
    end

    def default_tag
      Der::Tag::BOOLEAN
    end

  end
end

