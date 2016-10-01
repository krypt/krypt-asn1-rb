module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        class Primitive < SingularFieldDefinition

          def initialize(options)
            super(options.merge(
              parser: Parsers::Primitive,
              encoder: nil
            ))
          end

        end
      end
    end
  end
end