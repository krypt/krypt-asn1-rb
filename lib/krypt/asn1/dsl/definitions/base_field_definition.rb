module Krypt::Asn1
  module DSL
    module Definitions
      module BaseFieldDefinition

        attr_reader *%i{
          parser
          encoder
        }

        def initialize(options)
          @parser = options.fetch(:parser)
          @encoder = options.fetch(:encoder)
          @options = options[:options] || {}
        end

        def parse(asn1, instance)
          parser.parse(asn1, instance, self)
        end

        def encode(instance)
          encoder.encode(instance, self)
        end

        def custom_tag
          @options[:tag]
        end

        def custom_tag_class
          tagging ?
            Der::TagClass::CONTEXT_SPECIFIC :
            @options[:tag_class]
        end

        def tagging
          @options[:tagging]
        end

      end
    end
  end
end

