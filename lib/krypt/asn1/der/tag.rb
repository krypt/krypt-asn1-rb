require_relative 'cached_encoding'

module Krypt::Asn1
  class Der::Tag
    include Der::CachedEncoding

    # TODO move constants to Krypt::Asn1
    END_OF_CONTENTS  = 0x00
    BOOLEAN          = 0x01
    INTEGER          = 0x02
    BIT_STRING       = 0x03
    OCTET_STRING     = 0x04
    NULL             = 0x05
    OBJECT_ID        = 0x06

    ENUMERATED       = 0x0a

    UTF8_STRING      = 0x0c

    SEQUENCE         = 0x10
    SET              = 0x11
    NUMERIC_STRING   = 0x12
    PRINTABLE_STRING = 0x13
    T61_STRING       = 0x14
    VIDEOTEX_STRING  = 0x15
    IA5_STRING       = 0x16
    UTC_TIME         = 0x17
    GENERALIZED_TIME = 0x18
    GRAPHIC_STRING   = 0x19
    ISO64_STRING     = 0x1a
    GENERAL_STRING   = 0x1b
    UNIVERSAL_STRING = 0x1c

    BMP_STRING       = 0x1e

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

