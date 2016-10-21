module Krypt::Asn1
  module DSL
    module Definitions
      module Choice
        module Parsers

          module Value

            module_function

            def parse(value, instance, definition)
              instance.instance_variable_set(:@value, value)
            end

          end

        end
      end
    end
  end
end

