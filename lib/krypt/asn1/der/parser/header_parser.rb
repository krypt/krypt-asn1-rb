# encoding: BINARY

module Krypt::Asn1
  class Der::HeaderParser

    attr_reader :io

    def initialize(io_or_string)
      if io_or_string.respond_to?(:read)
        @io = io_or_string
      else
        init_string(io_or_string)
      end
    end

    def next
      return nil if @io.eof?
      tag = parse_tag
      length = parse_length
      Der::Header.new(tag, length, @io)
    end

    private

    def init_string(s)
      s = s.to_s.force_encoding(Encoding::BINARY)
      @io = StringIO.new(s)
    end

    def match(b, mask)
      (b & mask) == mask
    end

    def parse_tag
      b = @io.getbyte
      if match(b, Der::Tag::COMPLEX_TAG_MASK)
        complex_tag(b)
      else
        primitive_tag(b)
      end
    end

    def parse_length
      b = @io.readbyte
      mask = Der::Length::INDEFINITE_LENGTH_MASK

      if b == mask
        Der::Length.new(indefinite: true, encoding: b.chr)
      elsif match(b, mask)
        complex_definite_length(b)
      else
        Der::Length.new(length: b, encoding: b.chr)
      end
    end

    def primitive_tag(b)
      tc = b & Der::TagClass::PRIVATE
      cons = match(b, Der::Tag::CONSTRUCTED_MASK)

      tag = b & Der::Tag::COMPLEX_TAG_MASK
      Der::Tag.new(tag: tag, tag_class: tc, constructed: cons, encoding: b.chr)
    end

    def complex_tag(b)
      tc = b & Der::TagClass::PRIVATE
      cons = match(b, Der::Tag::CONSTRUCTED_MASK)

      tag = 0
      buf = b.chr
      b = @io.readbyte
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
        b = @io.readbyte
      end

      update.call
      Der::Tag.new(tag: tag, tag_class: tc, constructed: cons, encoding: buf)
    end

    def complex_definite_length(b)
      if b == 0xff
        raise "Initial octet of complex definite length shall not be 0xFF"
      end

      len = 0
      num_bytes = b & 0x7f
      buf = b.chr << @io.read(num_bytes)

      num_bytes.times do |i|
        len <<= 8
        len |= buf.getbyte(num_bytes - i)
      end

      Der::Length.new(length: len, encoding: buf)
    end

    def with_tc_and_cons(b)
      # TODO validate tag class
      tc = b & Der::TagClass::PRIVATE
      cons = match(b, Der::Tag::CONSTRUCTED_MASK)
      yield tc, cons
    end

  end
end

