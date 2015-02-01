module Krypt::Asn1
  module DSL
    module Definitions
      class AnyChoice < BaseChoiceDefinition

        def initialize(options)
          super(options.merge(codec: Codecs::Any))
        end

      end
    end
  end
end
