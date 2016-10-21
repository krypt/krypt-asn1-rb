module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        module Parsers
          module Any

            module_function

            def parse(asn1, instance, definition)
              instance.instance_variable_set(
                definition.iv_name,
                Asn1Object.new(asn1)
              )
            end

          end
        end
      end
    end
  end
end

