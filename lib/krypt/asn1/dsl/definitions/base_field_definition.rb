module Krypt::Asn1
  module DSL
    module Definitions
      class BaseFieldDefinition

        attr_reader *%i{
          parser
          encoder
        }

        def initialize(options)
          @parser = options.fetch(:parser)
          @encoder = options.fetch(:encoder)
          @options = options[:options] || {}
        end

        def optional?
          @options[:optional]
        end

        def mandatory?
          !optional?
        end

        def default_value?
          @options.has_key?(:default)
        end

        def default_value
          @options[:default]
        end

        def custom_tag
          @options[:tag]
        end

        def custom_tag_class
          @tagginng ? Der::TagClass::CONTEXT_SPECIFIC : @custom_tag_class
        end

      end
    end
  end
end
