require_relative 'parsers/any'
require_relative 'parsers/constructed'
require_relative 'parsers/constructed_of'
require_relative 'parsers/object'
require_relative 'parsers/primitive'

require_relative 'types/any'
require_relative 'types/constructed_of'
require_relative 'types/object'
require_relative 'types/primitive'
require_relative 'types/sequence_of'
require_relative 'types/set_of'

module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        module ClassMethods

          module Implementation

            module_function

            def add_definition(klass, definition_class, options)
              field_definition = definition_class.new(options)
              definition = klass.instance_variable_get(:@definition)
              definition.add(field_definition)
              klass.asn1_attr_reader(field_definition.name, field_definition.iv_name)
            end

            def declare_primitive(base, method, type)
              base.instance_eval do
                define_singleton_method method do |name, options=nil|
                  Implementation.add_definition(
                    self,
                    Types::Primitive,
                    type: type,
                    name: name,
                    options: options
                  )
                end
              end
            end

            def declare_any(base)
              base.instance_eval do
                def self.asn1_any (name, options=nil)
                  Implementation.add_definition(
                    self,
                    Types::Any,
                    name: name,
                    options: options
                  )
                end
              end
            end

            def declare_object(base)
              declare_constructed(base, :asn1_object, Types::Object)
            end

            def declare_sequence_of(base)
              declare_constructed(base, :asn1_sequence_of, Types::SequenceOf)
            end

            def declare_set_of(base)
              declare_constructed(base, :asn1_set_of, Types::SetOf)
            end

            private; module_function

            def declare_constructed(base, method, definition_class)
              base.instance_eval do
                define_singleton_method method do |name, type, options=nil|
                  Implementation.add_definition(
                    self,
                    definition_class,
                    type: type,
                    name: name,
                    options: options
                  )
                end
              end
            end

          end

          def self.extended(base)
            SharedClassMethods.define_on(base, Implementation)
          end

        end
      end
    end
  end
end

