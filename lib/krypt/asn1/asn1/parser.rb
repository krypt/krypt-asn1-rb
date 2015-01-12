require_relative 'parser/bit_string'
require_relative 'parser/boolean'
require_relative 'parser/default_parser'
require_relative 'parser/end_of_contents'
require_relative 'parser/generalized_time'
require_relative 'parser/integer_parser'
require_relative 'parser/lazy_parsable_primitive'
require_relative 'parser/null'
require_relative 'parser/object_id'
require_relative 'parser/utc_time'
require_relative 'parser/utf8_string'

module Krypt
  module Asn1
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

      UNIVERSAL_CLASSES = [
        Asn1::EndOfContents,
        Asn1::Boolean,
        Asn1::Integer,
        Asn1::BitString,
        Asn1::OctetString,
        Asn1::Null,
        Asn1::ObjectId,
        nil, # OBJECT_DESCRIPTOR
        nil, # EXTERNAL
        nil, # REAL
        Asn1::Enumerated,
        nil, # EMBEDDED_PDV
        Asn1::Utf8String,
        nil, # RELATIVE_OID
        nil, # UNIVERSAL 14
        nil, # UNIVERSAL 15
        Asn1::Sequence,
        Asn1::Set,
        Asn1::NumericString,
        Asn1::PrintableString,
        Asn1::T61String,
        Asn1::VideotexString,
        Asn1::Ia5String,
        Asn1::UtcTime,
        Asn1::GeneralizedTime,
        Asn1::GraphicString,
        Asn1::Iso64String,
        Asn1::GeneralString,
        Asn1::UniversalString,
        Asn1::CharacterString,
        Asn1::BmpString
      ]

      private_constant :PARSERS
      private_constant :UNIVERSAL_CLASSES

      module_function

      def new_parsable_primitive(object, der)
        Parser::LazyParsablePrimitive.new(object, der)
      end

      def parse(io_or_string)
        header = Der::Parser.new(io_or_string).next_header
        return nil unless header
        interpret(Der.new(header.tag, header.length, header.value))
      end

      def parse_value(object, bytes)
        PARSERS[object.class.default_tag].parse_value(bytes)
      end

      private; module_function

      def interpret(der)
        tag = der.tag
        t = tag.tag
        tc = tag.tag_class

        if tc == Der::TagClass::UNIVERSAL
          raise "Invalid tag for UNIVERSAL class: #{tag}" if t > 30
          c = UNIVERSAL_CLASSES[t]
          return c.from_der(der) if c
        end

        fallback = tag.constructed? ? Constructed : Primitive
        fallback.from_der(der)
      end

    end
  end
end

