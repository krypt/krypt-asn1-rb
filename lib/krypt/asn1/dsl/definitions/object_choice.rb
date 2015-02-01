module Krypt::Asn1
  module DSL
    module Definitions
      class ObjectChoice < BaseObjectDefinition

        def initialize
          super(Codecs::Choice)
        end

      end
    end
  end
end
