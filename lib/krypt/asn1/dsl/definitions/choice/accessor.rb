module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        module Accessor

          def asn1_type
            @asn1&.class
          end

          def tag
            @asn1&.tag
          end

          def value
            @asn1&.value
          end

        end
      end
    end
  end
end

