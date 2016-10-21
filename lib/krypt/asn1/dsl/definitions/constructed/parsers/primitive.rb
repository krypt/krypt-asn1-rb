module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        module Parsers

          module Primitive

            module_function

            def parse(value, instance, definition)
              instance.instance_variable_set(
                definition.iv_name,
                value
              )
            end

          end

        end
      end
    end
  end
end

