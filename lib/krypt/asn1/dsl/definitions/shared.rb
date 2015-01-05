module Krypt::Asn1
  module DSL
    module Definitions

      module Shared
        def init_methods
          declare_prim(:asn1_boolean, Krypt::Asn1::BOOLEAN)
          declare_prim(:asn1_integer, Krypt::Asn1::INTEGER)
          declare_prim(:asn1_bit_string, Krypt::Asn1::BIT_STRING)
          declare_prim(:asn1_octet_string, Krypt::Asn1::OCTET_STRING)
          declare_prim(:asn1_null, Krypt::Asn1::NULL)
          declare_prim(:asn1_object_id, Krypt::Asn1::OBJECT_ID)
          declare_prim(:asn1_enumerated, Krypt::Asn1::ENUMERATED)
          declare_prim(:asn1_utf8_string, Krypt::Asn1::UTF8_STRING)
          declare_prim(:asn1_numeric_string, Krypt::Asn1::NUMERIC_STRING)
          declare_prim(:asn1_printable_string, Krypt::Asn1::PRINTABLE_STRING)
          declare_prim(:asn1_t61_string, Krypt::Asn1::T61_STRING)
          declare_prim(:asn1_videotex_string, Krypt::Asn1::VIDEOTEX_STRING)
          declare_prim(:asn1_ia5_string, Krypt::Asn1::IA5_STRING)
          declare_prim(:asn1_utc_time, Krypt::Asn1::UTC_TIME)
          declare_prim(:asn1_generalized_time, Krypt::Asn1::GENERALIZED_TIME)
          declare_prim(:asn1_graphic_string, Krypt::Asn1::GRAPHIC_STRING)
          declare_prim(:asn1_iso64_string, Krypt::Asn1::ISO64_STRING)
          declare_prim(:asn1_general_string, Krypt::Asn1::GENERAL_STRING)
          declare_prim(:asn1_universal_string, Krypt::Asn1::UNIVERSAL_STRING)
          declare_prim(:asn1_bmp_string, Krypt::Asn1::BMP_STRING)

          declare_special_typed(:asn1_object, Codecs::Object)
          declare_special_typed(:asn1_sequence_of, Codecs::SequenceOf)
          declare_special_typed(:asn1_set_of, Codecs::SetOf)

          declare_any
        end
      end

    end
  end
end

