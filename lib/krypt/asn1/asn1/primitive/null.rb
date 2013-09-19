# encoding: BINARY

module Krypt::Asn1
  class Null < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::NULL
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

