module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        class ValueFieldDefinition < FieldDefinition

          protected

          def expected_tag_class
            custom_tag_class || Der::TagClass::UNIVERSAL
          end

        end
      end
    end
  end
end

