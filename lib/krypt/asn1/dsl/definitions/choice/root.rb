module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        class Root < FieldDefinition

          attr_reader :choices

          def initialize(options)
            super(
              parser: Parsers::Choice,
              encoder: nil
            )
            @choices = []
          end

          def add(field_definition)
            @choices << field_definition
            self
          end

        end
      end
    end
  end
end

