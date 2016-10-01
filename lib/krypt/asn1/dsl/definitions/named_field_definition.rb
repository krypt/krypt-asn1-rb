module Krypt::Asn1
  module DSL
    module Definitions
      class NamedFieldDefinition < FieldDefinition

        attr_reader *%i{
          name
          type
          iv_name
        }

        def initialize(options)
          super

          @name = options.fetch(:name)
          @type = options[:type] # ANY has no type
          @iv_name = "@#{name}".to_sym
        end

        def parse(asn1, instance)
          parser.parse(asn1, instance, self)
        end

        protected

        def expected_tag_class
          custom_tag_class || Der::TagClass::UNIVERSAL
        end

      end
    end
  end
end
