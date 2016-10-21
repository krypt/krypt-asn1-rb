module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        class Root < FieldDefinition

          attr_reader :fields

          def initialize
            super(
              parser: Parsers::Constructed,
              encoder: nil
            )
            @fields = []
          end

          def add(field_definition)
            @fields << field_definition
            self
          end

        end
      end
    end
  end
end

