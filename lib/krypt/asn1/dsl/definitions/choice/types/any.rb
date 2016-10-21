module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        module Types
          class Any < FieldDefinition

            def initialize(options)
              super(options.merge(
                parser: Parsers::Value,
                encoder: nil
              ))

              unless custom_tag
                raise "ANY cannot be optional without an explicit custom tag"
              end
            end

            def matches?(value)
              return true unless custom_tag

              tag = value.tag
              tag.tag == custom_tag && tag.tag_class == expected_tag_class
            end

          end
        end
      end
    end
  end
end
