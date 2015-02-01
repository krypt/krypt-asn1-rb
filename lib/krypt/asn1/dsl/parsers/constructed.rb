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

        def parse(asn1, instance, fields)
          value_matcher = ValueMatcher.new(asn1.value)
          fields.each do |field|
            assign_value(value_matcher, field, instance)
          end
          value_matcher.assert_done!
        end

        private; module_function

        def assign_value(value_matcher, field, instance)
          value = value_matcher.current_value
          if field.matches?(value)
            field.parse(value, instance)
            value_matcher.matched!
          else
            fallback_assign(field, instance)
          end
        end

        def fallback_assign(field, instance)
          if field.has_default?
            field.assign_default(instance)
          else
            raise "Mandatory field #{field.name} not found" if field.mandatory?
          end
        end

      end

    end
  end
end
