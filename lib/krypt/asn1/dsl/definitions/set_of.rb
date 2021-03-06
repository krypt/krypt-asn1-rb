module Krypt::Asn1
  module DSL
    module Definitions
      class SetOf < ConstructedOf

        def initialize(options)
          super(options.merge(
            parser: Parsers::ConstructedOf,
            encoder: nil
          ))
        end

        protected

        def default_tag
          SET
        end

      end
    end
  end
end
