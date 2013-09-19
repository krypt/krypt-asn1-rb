# encoding: BINARY

module Krypt::Rb::Asn1
  class GeneralString < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::GENERAL_STRING
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

