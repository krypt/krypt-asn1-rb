# encoding: BINARY

require_relative 'io_encodable'

module Krypt::Asn1::Rb
  class Tag
    include IOEncodable

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
      @tag = options[:tag] || argument_error('Tag must be provided')
      @tag_class = TagClass.of(options[:tag_class])
      @constructed = !!options[:constructed]
      @encoding = options[:encoding]
    end

    def constructed?; @constructed; end

    private

    def encode
      @encoding = @tag < 31 ? simple_tag : complex_tag
    end

    def simple_tag
      tag_byte = cons_or_null_byte
      tag_byte |= @tag_class.mask
      tag_byte |= @tag
      tag_byte.chr
    end

    def complex_tag
      tag_byte = cons_or_null_byte
      tag_byte |= @tag_class.mask
      tag_byte |= COMPLEX_TAG_MASK

      process_tag.prepend(tag_byte.chr)
    end

    def process_tag
      tmp = @tag
      buf = (tmp & 0x7f).chr
      tmp >>= 7

      while tmp > 0
        byte = tmp & 0x7f
        byte |= Length::INDEFINITE_LENGTH_MASK
        buf.prepend(byte.chr)
        tmp >>= 7
      end

      buf
    end

    def cons_or_null_byte
      @constructed ? CONSTRUCTED_MASK : 0x00
    end

  end
end

