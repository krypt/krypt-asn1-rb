# encoding: BINARY

module Krypt::Asn1
  class PrintableString < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::PRINTABLE_STRING
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

