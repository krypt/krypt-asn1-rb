module Krypt::Asn1
  module DSL
    module Accessors

      module Constructed

        def asn1_attr_reader(name, iv_name)
          define_method name do
            candidate = instance_variable_get(iv_name)
            candidate.value if candidate
          end
        end

      end

    end
  end
end

