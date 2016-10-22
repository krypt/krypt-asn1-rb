module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        module Types
          class Object < FieldDefinition

            attr_reader :type

            def initialize(options)
              super(options.merge(
                parser: Parsers::Object,
                encoder: nil
              ))
              @type = options[:type]
            end

            def matches?(value)
              # delegates matching to the root definition of the type
              type.instance_variable_get(:@definition).matches?(value, @options)
            end

          end
        end
      end
    end
  end
end

