# encoding: BINARY

module Krypt::Asn1
  class Utf8String < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::UTF8_STRING
      end
    end
    
    def parse_value(bytes)
      # TODO
    end

    def encode_value(value)
      # TODO
    end

  end
end

