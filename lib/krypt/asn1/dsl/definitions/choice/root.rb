module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        class Root

          attr_reader :choices

          def initialize
            @choices = []
          end

          def parse(asn1, instance)
            Parsers::Choice.parse(asn1, instance, self)
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

