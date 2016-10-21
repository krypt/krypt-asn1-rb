module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        class Root

          attr_reader :fields

          def initialize
            @fields = []
          end

          def parse(asn1, instance)
            Parsers::Constructed.parse(asn1, instance, self)
          end

          def encode(instance)
            #TODO
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

