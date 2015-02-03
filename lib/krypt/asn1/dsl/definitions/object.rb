module Krypt::Asn1
  module DSL
    module Definitions
      class Object < BaseSingularDefinition

        def initialize(options)
          super(options.merge(
            parser: Parsers::Object,
            encoder: nil
          ))
        end

      end
    end
  end
end
