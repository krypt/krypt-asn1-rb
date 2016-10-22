require_relative 'parser/bit_string'
require_relative 'parser/boolean'
require_relative 'parser/default_parser'
require_relative 'parser/end_of_contents'
require_relative 'parser/generalized_time'
require_relative 'parser/integer_parser'
require_relative 'parser/lazy_parsable_constructed'
require_relative 'parser/lazy_parsable_primitive'
require_relative 'parser/null'
require_relative 'parser/object_id'
require_relative 'parser/utc_time'
require_relative 'parser/utf8_string'

module Krypt
  module ASN1
    module Parser

      PARSERS = [
        EndOfContents,
        Boolean,
        IntegerParser, # INTEGER
        BitString,
        DefaultParser, # OCTET STRING
        Null,
        ObjectId,
        DefaultParser, # OBJECT_DESCRIPTOR
        DefaultParser, # EXTERNAL
        DefaultParser, # REAL
        IntegerParser, # ENUMERATED
        DefaultParser, # EMBEDDED_PDV
        Utf8String,
        DefaultParser, # RELATIVE_OID
        DefaultParser, # UNIVERSAL 14
        DefaultParser, # UNIVERSAL 15
        Sequence,
        Set,
        DefaultParser, # NUMERIC STRING
        DefaultParser, # PRINTABLE STRING
        DefaultParser, # T61 STRING
        DefaultParser, # VIDEOTEX STRING
        DefaultParser, # IA5 STRING
        UtcTime,
        GeneralizedTime,
        DefaultParser, # GRAPHIC STRING
        DefaultParser, # ISO64 STRING
        DefaultParser, # GENERAL STRING
        DefaultParser, # UNIVERSAL STRING
        DefaultParser, # CHARACTER STRING
        DefaultParser # BMP STRING
      ]

      private_constant :PARSERS

      module_function

      def new_parsable_primitive(object, der)
        Parser::LazyParsablePrimitive.new(object, der)
      end

      def new_parsable_constructed(object, der)
        Parser::LazyParsableConstructed.new(der)
      end

      def parse(io_or_string)
        header = Der::Parser.new(io_or_string).next_header
        return nil unless header
        interpret(Der.new(header.tag, header.length, header.value))
      end

      def parse_value(object, bytes)
        default_tag = object.class.default_tag
        parser = default_tag ? PARSERS[default_tag] : DefaultParser
        parser.parse_value(bytes)
      end

      private; module_function

      def interpret(der)
        tag = der.tag
        t = tag.tag
        tc = tag.tag_class

        if tc == Der::TagClass::UNIVERSAL
          raise "Invalid tag for UNIVERSAL class: #{tag}" if t > 30
          c = ASN1::UNIVERSAL_CLASSES[t]
          return c.from_der(der) if c
        end

        fallback = tag.constructed? ? Constructed : Primitive
        fallback.from_der(der)
      end

    end
  end
end

