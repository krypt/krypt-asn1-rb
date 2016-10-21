module Krypt::Asn1
  module DSL
    module Definitions
      module ConstructedOf
        class TypeDefinition

          attr_reader :type

          def initialize(type)
            @type = type
          end

          def parse(asn1, instance)
            parsed = asn1.value.reduce([]) do |objects, asn1|
              objects << type.from_asn1(asn1)
            end
            instance.instance_variable_set(
              :@value,
              Asn1Object.new(parsed)
            )
          end

        end
      end
    end
  end
end

