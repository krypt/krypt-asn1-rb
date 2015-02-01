module Krypt::Asn1
  module DSL
    module Definitions
      class Primitive < BaseConstructedDefinition

        attr_reader :type

        def initialize(options)
          super(options.merge(
            parser: Parsers::Primitive,
            encoder: nil
          ))
          @type = options.fetch(:type)
        end

        def matches?(value)
          tag = value.tag
          tag.tag == expected_tag && tag.tag_class == expected_tag_class
        end

        def assign_default(instance)
          value = UNIVERSAL_CLASSES[type].new(
            default_value,
            tag: expected_tag,
            tag_class: expected_tag_class
          )
          instance.instance_variable_set(iv_name, value)
        end

        private

        def expected_tag
          custom_tag || type
        end

        def expected_tag_class
          custom_tag_class || Der::TagClass::UNIVERSAL
        end

      end
    end
  end
end
