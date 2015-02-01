module Krypt::Asn1
  module DSL
    module Definitions
      class BaseConstructedDefinition < BaseFieldDefinition

        attr_reader *%i{
          name
          iv_name
          options
        }

        def initialize(options)
          super

          @name = options.fetch(:name)
          @iv_name = "@#{name}".to_sym
        end

        def parse(asn1, instance)
          parser.parse(asn1, instance, self)
        end

        def assign_default(instance)
          instance.instance_variable_set(
            iv_name,
            default_value
          )
        end

      end
    end
  end
end
