module Krypt::ASN1
  module DSL
    module Definitions

      module SharedClassMethods

        module_function

        def define_on(base, class_methods)
          class_methods.instance_eval do
            [
              [:asn1_boolean, Krypt::ASN1::Boolean],
              [:asn1_integer, Krypt::ASN1::Integer],
              [:asn1_bit_string, Krypt::ASN1::BitString],
              [:asn1_octet_string, Krypt::ASN1::OctetString],
              [:asn1_null, Krypt::ASN1::Null],
              [:asn1_object_id, Krypt::ASN1::ObjectId],
              [:asn1_enumerated, Krypt::ASN1::Enumerated],
              [:asn1_utf8_string, Krypt::ASN1::Utf8String],
              [:asn1_numeric_string, Krypt::ASN1::NumericString],
              [:asn1_printable_string, Krypt::ASN1::PrintableString],
              [:asn1_t61_string, Krypt::ASN1::T61String],
              [:asn1_videotex_string, Krypt::ASN1::VideotexString],
              [:asn1_ia5_string, Krypt::ASN1::Ia5String],
              [:asn1_utc_time, Krypt::ASN1::UtcTime],
              [:asn1_generalized_time, Krypt::ASN1::GeneralizedTime],
              [:asn1_graphic_string, Krypt::ASN1::GraphicString],
              [:asn1_iso64_string, Krypt::ASN1::Iso64String],
              [:asn1_general_string, Krypt::ASN1::GeneralString],
              [:asn1_universal_string, Krypt::ASN1::UniversalString],
              [:asn1_bmp_string, Krypt::ASN1::BmpString],
              [:asn1_boolean, Krypt::ASN1::Boolean],
              [:asn1_integer, Krypt::ASN1::Integer],
              [:asn1_bit_string, Krypt::ASN1::BitString],
              [:asn1_octet_string, Krypt::ASN1::OctetString],
              [:asn1_null, Krypt::ASN1::Null],
              [:asn1_object_id, Krypt::ASN1::ObjectId],
              [:asn1_enumerated, Krypt::ASN1::Enumerated],
              [:asn1_utf8_string, Krypt::ASN1::Utf8String],
              [:asn1_numeric_string, Krypt::ASN1::NumericString],
              [:asn1_printable_string, Krypt::ASN1::PrintableString],
              [:asn1_t61_string, Krypt::ASN1::T61String],
              [:asn1_videotex_string, Krypt::ASN1::VideotexString],
              [:asn1_ia5_string, Krypt::ASN1::Ia5String],
              [:asn1_utc_time, Krypt::ASN1::UtcTime],
              [:asn1_generalized_time, Krypt::ASN1::GeneralizedTime],
              [:asn1_graphic_string, Krypt::ASN1::GraphicString],
              [:asn1_iso64_string, Krypt::ASN1::Iso64String],
              [:asn1_general_string, Krypt::ASN1::GeneralString],
              [:asn1_universal_string, Krypt::ASN1::UniversalString],
              [:asn1_bmp_string, Krypt::ASN1::BmpString]
            ].each do |(method, type)|
              declare_primitive(base, method, type)
            end

            declare_object(base)
            declare_sequence_of(base)
            declare_set_of(base)
            declare_any(base)
          end
        end
      end

    end
  end
end

