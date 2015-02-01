module Krypt::Asn1
  module DSL
    module Definitions
      class Object < BaseObjectDefinition

        def initialize(options)
          super
          @min_size = 0
        end

        def add(field_definition)
          super
          increase_min_size(field_definition.options)
          self
        end

        def parse(asn1, instance)
          check_min_size(asn1)
          super
        end

        private

        def increase_min_size(options)
          options ||= {}
          need_increase = !(options[:optional] || options[:default])
          @min_size += 1 if need_increase
        end

        def check_min_size(asn1)
          if asn1.size < @min_size
            # TODO which?
            raise "Mandatory elements missing. Expected: #{@min_size} Got: #{asn1.size}"
          end
        end

      end
    end
  end
end
