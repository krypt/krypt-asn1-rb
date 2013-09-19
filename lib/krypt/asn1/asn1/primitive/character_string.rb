# encoding: BINARY

module Krypt::Asn1
  class CharacterString < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::CHARACTER_STRING
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

