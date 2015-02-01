module Krypt::Asn1
  class Null < Primitive

    def default_tag
      NULL
    end

    def initialize
      super(nil, tag: NULL, tag_class: Der::TagClass::UNIVERSAL)
    end

  end
end

