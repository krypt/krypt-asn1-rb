module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        module Types
          class Primitive < SingularFieldDefinition

            def initialize(options)
              super(options.merge(
                parser: Parsers::Value,
                encoder: nil
              ))
            end

          end
        end
      end
    end
  end
end
