module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        class Root
          include BaseRootDefinition

          attr_reader :fields, :default_tag

          def initialize(default_tag)
            @default_tag = default_tag
            @fields = []
          end

          def matches?(asn1, options)
            tag = asn1.tag
            tag.tag == expected_tag(options) &&
              tag.tag_class == expected_tag_class(options)
          end

          def parse(asn1, instance)
            Parsers::Constructed.parse(asn1, instance, self)
          end

          def add(field_definition)
            @fields << field_definition
            self
          end

          private

          def expected_tag(options)
            custom_tag(options) || default_tag
          end

        end
      end
    end
  end
end

