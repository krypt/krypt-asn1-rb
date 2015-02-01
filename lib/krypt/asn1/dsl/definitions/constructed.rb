module Krypt::Asn1
  module DSL
    module Definitions
      class Constructed < BaseConstructedDefinition

        attr_reader :type

        def initialize(options)
          super
          @type = options.fetch(:type)
        end

      end
    end
  end
end
