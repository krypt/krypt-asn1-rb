module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        module Parsers
          module Choice

            module_function

            def parse(asn1, instance, definition)
              found = definition.choices.each do |field|
                if field.matches?(asn1)
                  field.parse(unwrap_explicit(asn1, field), instance)
                  break true
                end
              end

              raise "No possible match for Choice found" unless found
            end

            private; module_function

            # Unwrap explicitly tagged values - they are wrapped in a
            # constructed container, leading to an Array of a single element
            def unwrap_explicit(value, field)
              field.tagging == :EXPLICIT ? value.first : value
            end

          end
        end
      end
    end
  end
end

