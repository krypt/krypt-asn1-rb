module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        module Types
          class Primitive < FieldDefinition

            attr_reader :type

            def initialize(options)
              super(options.merge(
                parser: Parsers::Value,
                encoder: nil
              ))
              @type = options[:type]
            end

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
end
