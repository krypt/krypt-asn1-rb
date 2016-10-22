require_relative 'asn1/helpers'
require_relative 'asn1/display_visitor'
require_relative 'asn1/asn1_base'
require_relative 'asn1/primitive'
require_relative 'asn1/constructed'
require_relative 'asn1/encoder'
require_relative 'asn1/parser'

module Krypt::ASN1

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

  class << self

    def decode(io_or_string)
      Parser.parse(io_or_string)
    end
    alias_method :parse, :decode

  end

end
