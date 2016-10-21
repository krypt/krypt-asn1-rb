module Krypt::Asn1
  module Der::HeaderParser

    module_function

    def next_header(io, parser)
      return nil if io.eof?
      tag = Der::TagParser.parse_tag(io)
      length = Der::LengthParser.parse_length(io)
      Der::Header.new(tag, length, parser)
    end

    def value_parser(io, header)
      length = header.length
      if length.indefinite?
        Der::IndefiniteValueParser.new(io)
      else
        Der::DefiniteValueParser.new(io, length.length)
      end
    end

  end
end

