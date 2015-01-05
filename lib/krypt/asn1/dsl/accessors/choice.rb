module Krypt::Asn1
  module DSL
    module Accessors

      module Choice

        def asn1_attr_accessor(name)
          define_method name do
            # TODO
          end

          define_method "#{name}=" do |value|
            # TODO
          end
        end

      end

    end
  end
end

