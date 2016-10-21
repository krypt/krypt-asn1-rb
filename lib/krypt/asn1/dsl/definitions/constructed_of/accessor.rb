module Krypt::Asn1
  module DSL
    module Definitions
      module ConstructedOf
        module Accessor

          def value
            @value&.value
          end

        end
      end
    end
  end
end

