module Krypt::Asn1
  class EndOfContents < Primitive

    def default_tag
      END_OF_CONTENTS
    end

    def initialize
      super(nil, tag: END_OF_CONTENTS, tag_class: Der::TagClass::UNIVERSAL)
    end

  end
end

