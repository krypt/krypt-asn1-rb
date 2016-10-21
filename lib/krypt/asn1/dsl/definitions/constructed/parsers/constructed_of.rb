module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        module Parsers

          module ConstructedOf

            module_function

            def parse(value, instance, definition)
              type = definition.type
              parsed = value.reduce([]) do |objects, asn1|
                objects << type.from_asn1(asn1)
              end
              instance.instance_variable_set(
                definition.iv_name,
                Asn1Object.new(parsed)
              )
            end

          end

        end
      end
    end
  end
end

