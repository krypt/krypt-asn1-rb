module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        class Any < NamedFieldDefinition

          def initialize(options)
            super(options.merge(
              parser: Parsers::Any,
              encoder: nil
            ))

            unless mandatory? || custom_tag
              raise "ANY cannot be optional without an explicit custom tag"
            end
          end

          def matches?(value)
            return true if mandatory?
            tag = value.tag
            # custom tag is set because field is optional
            tag.tag == custom_tag && tag.tag_class == expected_tag_class
          end

          def assign_default(instance)
            value = type.new(
              default_value,
              tag: expected_tag,
              tag_class: expected_tag_class
            )
            instance.instance_variable_set(iv_name, value)
          end

        end
      end
    end
  end
end
