module Krypt::ASN1
  module DSL
    module Definitions
      module Constructed
        module Types
          class Object < NamedFieldDefinition

            def initialize(options)
              super(options.merge(
                parser: Parsers::Object,
                encoder: nil
              ))
            end

            def matches?(value)
              # delegates matching to the root definition of the type
              type.instance_variable_get(:@definition).matches?(value, @options)
            end

            def assign_default(instance)
              # TODO
              #value = type.new(
              #  default_value,
              #  tag: expected_tag,
              #  tag_class: expected_tag_class
              #)
              #instance.instance_variable_set(iv_name, value)
            end

          end
        end
      end
    end
  end
end
