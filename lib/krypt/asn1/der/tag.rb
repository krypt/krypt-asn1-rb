module Krypt::Asn1
  class Der::Tag

    CONSTRUCTED_MASK = 0x20
    COMPLEX_TAG_MASK = 0x1f

    attr_reader :tag, :tag_class, :constructed
    alias constructed? constructed

    def initialize(options)
      @tag = options[:tag]
      @tag_class = options[:tag_class] || Der::TagClass::UNIVERSAL
      @constructed = !!options[:constructed]
      @encoding = options[:encoding]
    end

    def encoding
      Der::TagEncoder.encode(self)
    end

    def encode_to(io)
      io << encoding
    end

  end
end

