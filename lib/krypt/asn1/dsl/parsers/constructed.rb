module Krypt::Asn1
  module DSL
    module Parsers

      module Constructed

        class ValueMatcher
          def initialize(values)
            @values = values
            @current_index = 0
          end

          def current_value
            @values[@current_index]
          end

          def matched!
            @current_index += 1
          end

          def assert_done!
            if @values.size != @current_index
              raise "Unexpected values found"
            end
          end
        end

        module_function

        def parse(asn1, instance, definition)
          value_matcher = ValueMatcher.new(asn1.value)
          definition.fields.each do |field|
            assign_value(value_matcher, field, instance)
          end
          value_matcher.assert_done!
        end

        private; module_function

        def assign_value(value_matcher, field, instance)
          value = value_matcher.current_value
          if field.matches?(value)
            field.parse(unwrap_explicit(value, field), instance)
            value_matcher.matched!
          else
            fallback_assign(field, instance)
          end
        end

        def fallback_assign(field, instance)
          if field.default_value?
            field.assign_default(instance)
          else
            raise "Mandatory field #{field.name} not found" if field.mandatory?
          end
        end

        # Unwrap explicitly tagged values - they are wrapped in a
        # constructed container, leading to an Array of a single element
        def unwrap_explicit(value, field)
          field.tagging == :EXPLICIT ? value.first : value
        end

      end

    end
  end
end
