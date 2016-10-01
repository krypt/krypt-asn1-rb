module Krypt::Asn1
  module DSL
    module Definitions
      class Root < FieldDefinition

        attr_reader :fields

        def initialize(options)
          super
          @fields = []
        end

        def add(field_definition)
          @fields << field_definition
          self
        end

        def parse(asn1, instance)
          parser.parse(asn1, instance, self)
        end

      end
    end
  end
end
