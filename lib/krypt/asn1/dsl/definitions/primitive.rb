module Krypt::Asn1
  module DSL
    module Definitions
      class Primitive < BaseConstructedDefinition

        attr_reader :type

        def initialize(options)
          super(options.merge(codec: Codecs::Primitive))
          @type = options.fetch(:type)
        end

      end
    end
  end
end
