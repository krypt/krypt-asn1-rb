module Krypt::Asn1
  module DSL
    module Definitions
      class BaseFieldDefinition

        attr_reader *%i{
          options
          parser
          encoder
        }

        def initialize(options)
          @options = options[:options] || {}
          @parser = options.fetch(:parser)
          @encoder = options.fetch(:encoder)
        end

        def has_default?
          options.has_key?(:default)
        end

        def default_value
          options[:default]
        end

        def optional?
          options[:optional]
        end

        def mandatory?
          !optional?
        end

        def custom_tag?
          !!options[:tag]
        end

        def custom_tag
          options[:tag]
        end

        def custom_tag_class?
          options[:tagging] || options[:tag_class]
        end

        def custom_tag_class
          if options[:tagging]
            Der::TagClass::CONTEXT_SPECIFIC
          else
            options[:tag_class]
          end
        end

      end
    end
  end
end
