module Krypt::Asn1
  module DSL
    module Definitions
      class AnyChoice < BaseChoiceDefinition

        def initialize(options)
          super(options.merge(
            parser: nil,
            encoder: nil
          ))
        end

      end
    end
  end
end
