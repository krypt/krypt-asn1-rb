# encoding: BINARY

module Krypt::Rb::Asn1
  class Enumerated < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::ENUMERATED
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

