module Krypt::Asn1
  module DSL
    module Definitions
      module Constructed
        module ClassMethods

          module Implementation
            module_function

            def declare_primitive(base, method, type)
              base.instance_eval do
                define_singleton_method method do |name, options=nil|
                  DSL::Helper.add_definition(
                    self,
                    Definitions::Constructed::Primitive,
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
                  DSL::Helper.add_definition(
                    self,
                    Definitions::Constructed::Any,
                    name: name,
                    options: options
                  )
                end
              end
            end

            def declare_object(base)
              declare_constructed(base, :asn1_object, Definitions::Constructed::Object)
            end

            def declare_sequence_of(base)
              declare_constructed(base, :asn1_sequence_of, Definitions::Constructed::SequenceOf)
            end

            def declare_set_of(base)
              declare_constructed(base, :asn1_set_of, Definitions::Constructed::SetOf)
            end

            private; module_function

            def declare_constructed(base, method, definition_class)
              base.instance_eval do
                define_singleton_method method do |name, type, options=nil|
                  DSL::Helper.add_definition(
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

