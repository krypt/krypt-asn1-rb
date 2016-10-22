module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        module Types
          class ConstructedOf < FieldDefinition

            def initialize(options)
              super(options.merge(
                parser: Parsers::ConstructedOf,
                encoder: nil
              ))
            end

            def matches?(value)
              tag = value.tag
              tag.tag == expected_tag && tag.tag_class == expected_tag_class
            end

            private

            def expected_tag
              custom_tag || default_tag
            end

          end
        end
      end
    end
  end
end

