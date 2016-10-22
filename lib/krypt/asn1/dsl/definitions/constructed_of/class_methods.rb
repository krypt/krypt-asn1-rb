module Krypt::ASN1
  module DSL
    module Definitions
      module ConstructedOf
        module ClassMethods

          def asn1_type(type)
            type_definition = TypeDefinition.new(type)
            definition = instance_variable_get(:@definition)
            definition.type_definition = type_definition
          end

        end
      end
    end
  end
end

