module Krypt::Asn1
  module DSL
    module Definitions
      class BaseObjectDefinition

        attr_reader :codec

        def initialize(codec)
          @codec = codec
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
