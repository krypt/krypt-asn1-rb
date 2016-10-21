module Krypt::Asn1
  module Der::TagEncoder

    module_function

    def encode(tag)
      tag.tag < 31 ? simple_tag(tag) : complex_tag(tag)
    end

    private; module_function

    def simple_tag(tag)
      tag_byte = cons_or_null_byte(tag)
      tag_byte |= tag.tag_class
      tag_byte |= tag.tag
      tag_byte.chr
    end

    def complex_tag(tag)
      tag_byte = cons_or_null_byte(tag)
      tag_byte |= tag.tag_class
      tag_byte |= Der::Tag::COMPLEX_TAG_MASK

      process_tag(tag.tag).prepend(tag_byte.chr)
    end

    def process_tag(tag)
      buf = (tag & 0x7f).chr
      tag >>= 7

      while tag > 0
        byte = tag & 0x7f
        byte |= Der::Length::INDEFINITE_LENGTH_MASK
        buf.prepend(byte.chr)
        tag >>= 7
      end

      buf
    end

    def cons_or_null_byte(tag)
      tag.constructed? ? Der::Tag::CONSTRUCTED_MASK : 0x00
    end

  end
end

