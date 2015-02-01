module Krypt::Asn1
  module DSL
    module Definitions
      class Object < BaseObjectDefinition

        def initialize(codec)
          super
          @min_size = 0
        end

        def add(field_definition)
          super
          increase_min_size(field_definition.options)
          self
        end

        private

        def increase_min_size(options)
          options ||= {}
          need_increase = !(options[:optional] || options[:default])
          @min_size += 1 if need_increase
        end

      end
    end
  end
end
