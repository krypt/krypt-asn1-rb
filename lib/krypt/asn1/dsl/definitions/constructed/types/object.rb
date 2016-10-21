module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        module Types
          class Object < SingularFieldDefinition

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
  end
end
