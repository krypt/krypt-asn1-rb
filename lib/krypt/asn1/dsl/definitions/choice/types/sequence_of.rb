module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        module Types
          class SequenceOf < ConstructedOf

            protected

            def default_tag
              SEQUENCE
            end

          end
        end
      end
    end
  end
end
