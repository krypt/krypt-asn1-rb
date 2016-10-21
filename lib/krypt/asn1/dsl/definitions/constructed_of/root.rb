module Krypt::Asn1
  module DSL
    module Definitions
      module ConstructedOf
        class Root
          include BaseRootDefinition

          attr_accessor :type_definition, :default_tag

          def initialize(default_tag)
            @default_tag = default_tag
          end

          def matches?(asn1, options)
            tag = asn1.tag
            tag.tag == expected_tag(options) &&
              tag.tag_class == expected_tag_class(options)
          end

          def parse(asn1, instance)
            @type_definition.parse(asn1, instance)
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

