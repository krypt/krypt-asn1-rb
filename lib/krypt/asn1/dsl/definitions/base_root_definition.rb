module Krypt::Asn1
  module DSL
    module Definitions
      module BaseRootDefinition

        protected

        def custom_tag(options)
          options[:tag]
        end

        def custom_tag_class(options)
          options[:tagging] ?
            Der::TagClass::CONTEXT_SPECIFIC :
            options[:tag_class]
        end

        def expected_tag_class(options)
          custom_tag_class(options) || Der::TagClass::UNIVERSAL
        end

      end
    end
  end
end

