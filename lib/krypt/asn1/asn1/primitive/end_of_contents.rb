# encoding: BINARY

module Krypt::Asn1
  class EndOfContents < Primitive

    def self.default_tag
      END_OF_CONTENTS
    end

    def initialize
      super(nil, tag: END_OF_CONTENTS, tag_class: Der::TagClass::UNIVERSAL)
    end

    def parse_value(bytes)
      nil
    end

    def encode_value(value)
      nil
    end

  end
end

