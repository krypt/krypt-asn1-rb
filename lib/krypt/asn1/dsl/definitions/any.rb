module Krypt::Asn1
  module DSL
    module Definitions
      class Any < BaseConstructedDefinition

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
