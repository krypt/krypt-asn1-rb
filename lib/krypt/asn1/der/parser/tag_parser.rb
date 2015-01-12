# encoding: BINARY

module Krypt::Asn1
  module Der::TagParser

    module_function

    def parse_tag(io)
      b = io.getbyte
      if match(b, Der::Tag::COMPLEX_TAG_MASK)
        complex_tag(b, io)
      else
        primitive_tag(b)
      end
    end

    private; module_function

    def match(b, mask)
      (b & mask) == mask
    end

    def primitive_tag(b)
      tc, cons = tc_and_cons(b)

      tag = b & Der::Tag::COMPLEX_TAG_MASK
      Der::Tag.new(tag: tag, tag_class: tc, constructed: cons, encoding: b.chr)
    end

    def complex_tag(b, io)
      tc, cons = tc_and_cons(b)

      tag = 0
      buf = b.chr
      b = io.readbyte
      if b == Der::Length::INDEFINITE_LENGTH_MASK
        raise "Bits 7 to 1 of the first subsequent octet shall not be 0 for complex tag encodings"
      end

      update = lambda do
        tag <<= 7
        tag |= (b & 0x7f)
        buf << b
      end

      while match(b, Der::Length::INDEFINITE_LENGTH_MASK)
        update.call
        b = io.readbyte
      end

      update.call
      Der::Tag.new(tag: tag, tag_class: tc, constructed: cons, encoding: buf)
    end

    def tc_and_cons(b)
      # TODO validate tag class
      tc = b & Der::TagClass::PRIVATE
      cons = match(b, Der::Tag::CONSTRUCTED_MASK)
      return tc, cons
    end
  end
end
