module Krypt::Asn1
  module DSL
    module Definitions
      class BaseObjectDefinition < BaseFieldDefinition

        attr_reader :parser, :encoder

        def initialize(options)
          super
          @fields = []
        end

        def add(field_definition)
          @fields << field_definition
          self
        end

        def parse(asn1, instance)
          parser.parse(asn1, instance, @fields)
        end

      end
    end
  end
end
