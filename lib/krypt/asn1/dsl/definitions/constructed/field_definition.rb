module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        class FieldDefinition
          include BaseFieldDefinition

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

        end
      end
    end
  end
end

