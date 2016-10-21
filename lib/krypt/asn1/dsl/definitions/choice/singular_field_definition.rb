module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        class SingularFieldDefinition < FieldDefinition

          def matches?(value)
            tag = value.tag
            tag.tag == expected_tag && tag.tag_class == expected_tag_class
          end

          private

          def expected_tag
            custom_tag || type.default_tag
          end

        end
      end
    end
  end
end

