module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        class SequenceOf < ConstructedOf

          def initialize(options)
            super(options.merge(
              parser: Parsers::ConstructedOf,
              encoder: nil
            ))
          end

          protected

          def default_tag
            SEQUENCE
          end

        end
      end
    end
  end
end
