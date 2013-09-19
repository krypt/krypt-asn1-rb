# encoding: BINARY

module Krypt::Rb::Asn1
  class Iso64String < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::ISO64_STRING
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

