module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        module Parsers
          module Object

            module_function

            def parse(value, instance, definition)
              parsed = definition.type.from_asn1(value)
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

