module Krypt::Asn1
  module DSL
    module Definitions

      module SharedClassMethods
        def init_methods
          declare_primitive(:asn1_boolean, Krypt::Asn1::Boolean)
          declare_primitive(:asn1_integer, Krypt::Asn1::Integer)
          declare_primitive(:asn1_bit_string, Krypt::Asn1::BitString)
          declare_primitive(:asn1_octet_string, Krypt::Asn1::OctetString)
          declare_primitive(:asn1_null, Krypt::Asn1::Null)
          declare_primitive(:asn1_object_id, Krypt::Asn1::ObjectId)
          declare_primitive(:asn1_enumerated, Krypt::Asn1::Enumerated)
          declare_primitive(:asn1_utf8_string, Krypt::Asn1::Utf8String)
          declare_primitive(:asn1_numeric_string, Krypt::Asn1::NumericString)
          declare_primitive(:asn1_printable_string, Krypt::Asn1::PrintableString)
          declare_primitive(:asn1_t61_string, Krypt::Asn1::T61String)
          declare_primitive(:asn1_videotex_string, Krypt::Asn1::VideotexString)
          declare_primitive(:asn1_ia5_string, Krypt::Asn1::Ia5String)
          declare_primitive(:asn1_utc_time, Krypt::Asn1::UtcTime)
          declare_primitive(:asn1_generalized_time, Krypt::Asn1::GeneralizedTime)
          declare_primitive(:asn1_graphic_string, Krypt::Asn1::GraphicString)
          declare_primitive(:asn1_iso64_string, Krypt::Asn1::Iso64String)
          declare_primitive(:asn1_general_string, Krypt::Asn1::GeneralString)
          declare_primitive(:asn1_universal_string, Krypt::Asn1::UniversalString)
          declare_primitive(:asn1_bmp_string, Krypt::Asn1::BmpString)

          declare_object
          declare_sequence_of
          declare_set_of
          declare_any
        end
      end

    end
  end
end

