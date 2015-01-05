# encoding: BINARY

module Krypt::Asn1
  class Parser

    def parse(io_or_string)
      header = Der::HeaderParser.new(io_or_string).next
      return nil unless header
      interpret(header.asn1_object)
    end

    private

    UNIVERSAL_CLASSES = [
      EndOfContents,
      Boolean,
      Integer,
      BitString,
      OctetString,
      Null,
      ObjectId,
      nil, # OBJECT_DESCRIPTOR
      nil, # EXTERNAL
      nil, # REAL
      Enumerated,
      nil, # EMBEDDED_PDV
      Utf8String,
      nil, # RELATIVE_OID
      nil, # UNIVERSAL 14
      nil, # UNIVERSAL 15
      Sequence,
      Set,
      NumericString,
      PrintableString,
      T61String,
      VideotexString,
      Ia5String,
      UtcTime,
      GeneralizedTime,
      GraphicString,
      Iso64String,
      GeneralString,
      UniversalString,
      CharacterString,
      BmpString
    ]
    private_constant :UNIVERSAL_CLASSES


    def interpret(der)
      tag = der.tag
      t = tag.tag
      tc = tag.tag_class.tag_class
      validate(t, tc)

      if tc == :UNIVERSAL
        c = UNIVERSAL_CLASSES[t]
        return c.from_der(der) if c
      end

      fallback = tag.constructed? ? Constructed : Primitive
      fallback.from_der(der)
    end

    def validate(tag, tc)
      if tag > 30 && tc == :UNIVERSAL
        raise "Invalid tag for UNIVERSAL class: #{tag}"
      end
    end

  end
end

