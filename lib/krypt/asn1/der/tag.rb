require_relative 'cached_encoding'

module Krypt::Asn1
  class Der::Tag
    include Der::CachedEncoding

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

    private

    def encode
      Der::TagEncoder.encode(self)
    end

  end
end

