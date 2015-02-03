module Krypt::Asn1
  module DSL
    module Definitions
      class Primitive < BaseSingularDefinition

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
