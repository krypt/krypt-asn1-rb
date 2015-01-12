require_relative 'encoder/bit_string'
require_relative 'encoder/boolean'
require_relative 'encoder/default_encoder'
require_relative 'encoder/generalized_time'
require_relative 'encoder/integer_encoder'
require_relative 'encoder/lazy_encodable_primitive'
require_relative 'encoder/null'
require_relative 'encoder/object_id'
require_relative 'encoder/string_encoder'
require_relative 'encoder/utc_time'
require_relative 'encoder/utf8_string'

require_relative 'encoder/sequence'
require_relative 'encoder/set'

module Krypt::Asn1
  module Encoder

    ENCODERS = [
      Null, # END OF CONTENTS
      Boolean,
      IntegerEncoder, # INTEGER
      BitString,
      StringEncoder, # OCTET STRING
      Null,
      ObjectId,
      DefaultEncoder, # OBJECT_DESCRIPTOR
      DefaultEncoder, # EXTERNAL
      DefaultEncoder, # REAL
      IntegerEncoder, # ENUMERATED
      DefaultEncoder, # EMBEDDED_PDV
      Utf8String,
      DefaultEncoder, # RELATIVE_OID
      DefaultEncoder, # UNIVERSAL 14
      DefaultEncoder, # UNIVERSAL 15
      Sequence,
      Set,
      StringEncoder, # NUMERIC STRING
      StringEncoder, # PRINTABLE STRING
      StringEncoder, # T61 STRING
      StringEncoder, # VIDEOTEX STRING
      StringEncoder, # IA5 STRING
      UtcTime,
      GeneralizedTime,
      StringEncoder, # GRAPHIC STRING
      StringEncoder, # ISO64 STRING
      StringEncoder, # GENERAL STRING
      StringEncoder, # UNIVERSAL STRING
      StringEncoder, # CHARACTER STRING
      StringEncoder # BMP STRING
    ]
    private_constant :ENCODERS

    module_function

    def new_encodable_primitive(object, value, options)
      Encoder::LazyEncodablePrimitive.new(object, value, options)
    end

    def encode_value(object, value)
      ENCODERS[object.class.default_tag].encode_value(object, value)
    end

  end
end
