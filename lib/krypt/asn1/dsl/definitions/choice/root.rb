module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        class Root
          include BaseRootDefinition

          attr_reader :choices

          def initialize
            @choices = []
          end

          def matches?(asn1, options)
            # TODO handle options
            choices.any? { |field| field.matches?(asn1) }
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

