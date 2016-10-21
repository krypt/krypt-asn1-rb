module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        module Types
          class SetOf < ConstructedOf

            protected

            def default_tag
              SET
            end

          end
        end
      end
    end
  end
end
