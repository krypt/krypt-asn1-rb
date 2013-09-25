# encoding: BINARY

module Krypt::Asn1
  class EndOfContents < Primitive

    def initialize
      super(tag: END_OF_CONTENTS, tag_class: :UNIVERSAL)
    end
    
    def parse_value(bytes)
      nil
    end

    def encode_value(value)
      nil
    end

  end
end

