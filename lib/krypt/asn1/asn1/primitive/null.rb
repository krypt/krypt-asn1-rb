module Krypt::ASN1
  class Null < Primitive

    def self.default_tag
      NULL
    end

    def initialize(
      value=nil,
      options={ tag: NULL, tag_class: Der::TagClass::UNIVERSAL }
    )
      super(value, options)
    end

  end
end

