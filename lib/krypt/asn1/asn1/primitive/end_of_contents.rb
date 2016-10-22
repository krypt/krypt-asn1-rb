module Krypt::ASN1
  class EndOfContents < Primitive

    def self.default_tag
      END_OF_CONTENTS
    end

    def initialize(
      value=nil,
      options={ tag: END_OF_CONTENTS, tag_class: Der::TagClass::UNIVERSAL }
    )
      super(value, options)
    end

  end
end

