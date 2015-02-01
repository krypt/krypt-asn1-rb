module Krypt::Asn1
  module DSL
    module Definitions
      class PrimitiveChoice < BaseChoiceDefinition

        attr_reader :type

        def initialize(options)
          super(options.merge(codec: Codecs::Primitive))
          @type = options.fetch(:type)
        end

      end
    end
  end
end
