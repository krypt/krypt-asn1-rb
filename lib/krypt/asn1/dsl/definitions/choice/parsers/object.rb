module Krypt::ASN1
  module DSL
    module Definitions
      module Choice
        module Parsers

          module Object

            module_function

            def parse(value, instance, definition)
              parsed = definition.type.from_asn1(value)
              instance.instance_variable_set(
                :@value,
                ASN1Object.new(parsed)
              )
            end

          end

        end
      end
    end
  end
end

