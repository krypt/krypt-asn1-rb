module Krypt::Asn1
  module DSL
    module Definitions
      class BaseSingularDefinition < BaseConstructedDefinition

        def matches?(value)
          tag = value.tag
          tag.tag == expected_tag && tag.tag_class == expected_tag_class
        end

        def assign_default(instance)
          value = type.new(
            default_value,
            tag: expected_tag,
            tag_class: expected_tag_class
          )
          instance.instance_variable_set(iv_name, value)
        end

        private

        def expected_tag
          custom_tag || type.default_tag
        end

      end
    end
  end
end
