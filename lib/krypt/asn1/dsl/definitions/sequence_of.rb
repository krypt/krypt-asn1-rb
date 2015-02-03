module Krypt::Asn1
  module DSL
    module Definitions
      class SequenceOf < BaseConstructedDefinition

        def initialize(options)
          super(options.merge(
            parser: Parsers::ConstructedOf,
            encoder: nil
          ))
        end

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
          custom_tag || SEQUENCE
        end

      end
    end
  end
end
