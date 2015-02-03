module Krypt::Asn1
  module DSL
    module Definitions

      module SharedClassMethods

        module_function

        def define_on(base, class_methods)
          class_methods.declare_primitive(base, :asn1_boolean, Krypt::Asn1::Boolean)
          class_methods.declare_primitive(base, :asn1_integer, Krypt::Asn1::Integer)
          class_methods.declare_primitive(base, :asn1_bit_string, Krypt::Asn1::BitString)
          class_methods.declare_primitive(base, :asn1_octet_string, Krypt::Asn1::OctetString)
          class_methods.declare_primitive(base, :asn1_null, Krypt::Asn1::Null)
          class_methods.declare_primitive(base, :asn1_object_id, Krypt::Asn1::ObjectId)
          class_methods.declare_primitive(base, :asn1_enumerated, Krypt::Asn1::Enumerated)
          class_methods.declare_primitive(base, :asn1_utf8_string, Krypt::Asn1::Utf8String)
          class_methods.declare_primitive(base, :asn1_numeric_string, Krypt::Asn1::NumericString)
          class_methods.declare_primitive(base, :asn1_printable_string, Krypt::Asn1::PrintableString)
          class_methods.declare_primitive(base, :asn1_t61_string, Krypt::Asn1::T61String)
          class_methods.declare_primitive(base, :asn1_videotex_string, Krypt::Asn1::VideotexString)
          class_methods.declare_primitive(base, :asn1_ia5_string, Krypt::Asn1::Ia5String)
          class_methods.declare_primitive(base, :asn1_utc_time, Krypt::Asn1::UtcTime)
          class_methods.declare_primitive(base, :asn1_generalized_time, Krypt::Asn1::GeneralizedTime)
          class_methods.declare_primitive(base, :asn1_graphic_string, Krypt::Asn1::GraphicString)
          class_methods.declare_primitive(base, :asn1_iso64_string, Krypt::Asn1::Iso64String)
          class_methods.declare_primitive(base, :asn1_general_string, Krypt::Asn1::GeneralString)
          class_methods.declare_primitive(base, :asn1_universal_string, Krypt::Asn1::UniversalString)
          class_methods.declare_primitive(base, :asn1_bmp_string, Krypt::Asn1::BmpString)

          class_methods.declare_object(base)
          class_methods.declare_sequence_of(base)
          class_methods.declare_set_of(base)
          class_methods.declare_any(base)
        end
      end

    end
  end
end

