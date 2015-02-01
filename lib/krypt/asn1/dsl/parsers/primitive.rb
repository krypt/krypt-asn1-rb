module Krypt::Asn1
  module DSL
    module Parsers

      module Primitive

        module_function

        def parse(value, instance, field)
          instance.instance_variable_set(
            field.iv_name,
            value
          )
        end

      end

    end
  end
end
