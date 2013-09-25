require_relative 'cached_encoding'

module Krypt::Asn1
  class Der::Tag
    include Der::CachedEncoding
 
    CONSTRUCTED_MASK = 0x20
    COMPLEX_TAG_MASK = 0x1f

    attr_reader :tag, :tag_class

    def initialize(options)
      @tag = options[:tag]
      tc = options[:tag_class]
      @tag_class = tc ? Der::TagClass.of(tc) : Der::TagClass.of(:UNIVERSAL)
      @constructed = !!options[:constructed]
      @encoding = options[:encoding]
    end

    def constructed?; @constructed; end

    private

    def encode
      @encoding = Der::TagEncoder.encode(self)
    end

  end
end

