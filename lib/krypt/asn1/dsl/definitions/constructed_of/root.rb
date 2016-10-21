module Krypt::Asn1
  module DSL
    module Definitions
      module ConstructedOf
        class Root

          attr_accessor :type_definition

          def parse(asn1, instance)
            @type_definition.parse(asn1, instance)
          end

        end
      end
    end
  end
end

