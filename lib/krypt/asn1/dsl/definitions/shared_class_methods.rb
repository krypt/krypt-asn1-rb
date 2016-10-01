module Krypt::Asn1
  module DSL
    module Definitions

      module SharedClassMethods

        module_function

        def define_on(base, class_methods)
          class_methods.instance_eval do
            [
              [:asn1_boolean, Krypt::Asn1::Boolean],
              [:asn1_integer, Krypt::Asn1::Integer],
              [:asn1_bit_string, Krypt::Asn1::BitString],
              [:asn1_octet_string, Krypt::Asn1::OctetString],
              [:asn1_null, Krypt::Asn1::Null],
              [:asn1_object_id, Krypt::Asn1::ObjectId],
              [:asn1_enumerated, Krypt::Asn1::Enumerated],
              [:asn1_utf8_string, Krypt::Asn1::Utf8String],
              [:asn1_numeric_string, Krypt::Asn1::NumericString],
              [:asn1_printable_string, Krypt::Asn1::PrintableString],
              [:asn1_t61_string, Krypt::Asn1::T61String],
              [:asn1_videotex_string, Krypt::Asn1::VideotexString],
              [:asn1_ia5_string, Krypt::Asn1::Ia5String],
              [:asn1_utc_time, Krypt::Asn1::UtcTime],
              [:asn1_generalized_time, Krypt::Asn1::GeneralizedTime],
              [:asn1_graphic_string, Krypt::Asn1::GraphicString],
              [:asn1_iso64_string, Krypt::Asn1::Iso64String],
              [:asn1_general_string, Krypt::Asn1::GeneralString],
              [:asn1_universal_string, Krypt::Asn1::UniversalString],
              [:asn1_bmp_string, Krypt::Asn1::BmpString],
              [:asn1_boolean, Krypt::Asn1::Boolean],
              [:asn1_integer, Krypt::Asn1::Integer],
              [:asn1_bit_string, Krypt::Asn1::BitString],
              [:asn1_octet_string, Krypt::Asn1::OctetString],
              [:asn1_null, Krypt::Asn1::Null],
              [:asn1_object_id, Krypt::Asn1::ObjectId],
              [:asn1_enumerated, Krypt::Asn1::Enumerated],
              [:asn1_utf8_string, Krypt::Asn1::Utf8String],
              [:asn1_numeric_string, Krypt::Asn1::NumericString],
              [:asn1_printable_string, Krypt::Asn1::PrintableString],
              [:asn1_t61_string, Krypt::Asn1::T61String],
              [:asn1_videotex_string, Krypt::Asn1::VideotexString],
              [:asn1_ia5_string, Krypt::Asn1::Ia5String],
              [:asn1_utc_time, Krypt::Asn1::UtcTime],
              [:asn1_generalized_time, Krypt::Asn1::GeneralizedTime],
              [:asn1_graphic_string, Krypt::Asn1::GraphicString],
              [:asn1_iso64_string, Krypt::Asn1::Iso64String],
              [:asn1_general_string, Krypt::Asn1::GeneralString],
              [:asn1_universal_string, Krypt::Asn1::UniversalString],
              [:asn1_bmp_string, Krypt::Asn1::BmpString]
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

