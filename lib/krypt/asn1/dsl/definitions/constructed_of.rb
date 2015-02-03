module Krypt::Asn1
  module DSL
    module Definitions
      class ConstructedOf < BaseConstructedDefinition

        def matches?(value)
          tag = value.tag
          tag.tag == expected_tag && tag.tag_class == expected_tag_class
        end

        def assign_default(instance)
          # TODO
          raise "TODO Implement"
        end

        private

        def expected_tag
          custom_tag || default_tag
        end

      end
    end
  end
end
