module Krypt::Asn1
  module DSL
    module Definitions
      class ConstructedChoice < BaseChoiceDefinition

        attr_reader :type

        def initialize(options)
          super
          @type = options.fetch(:type)
        end

      end
    end
  end
end
