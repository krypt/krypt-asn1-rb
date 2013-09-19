# encoding: BINARY

module Krypt::Rb::Asn1
  class Boolean < Primitive

    def initialize(options)
      super(options)
      unless options[:tag]
        @tag = Der::Tag::BOOLEAN
      end
    end
    
    def parse_value(bytes)
      unless bytes.size == 1
        raise "Invalid BOOLEAN value: #{bytes}"
      end 

      if bytes == "\x00" 
        false
      else
        true
      end
    end

    def encode_value(value)
      if value
        "\xff"
      else
        "\x00"
      end
    end

  end
end

