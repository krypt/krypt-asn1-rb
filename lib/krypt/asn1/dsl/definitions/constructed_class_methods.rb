module Krypt::Asn1
  module DSL
    module Definitions

      module ConstructedClassMethods
        extend SharedClassMethods

        class << self
          define_method :declare_primitive do |method, type|
            define_method method do |name, options=nil|
              DSL::Helper.add_constructed_definition(
                self,
                Definitions::Primitive,
                type: type,
                name: name,
                options: options
              )
            end
          end

          define_method :declare_object do
            define_method :asn1_object do |name, type, options=nil|
              DSL::Helper.add_constructed_definition(
                self,
                Definitions::Object,
                type: type,
                name: name,
                options: options
              )
            end
          end

          define_method :declare_sequence_of do
            define_method :asn1_sequence_of do |name, type, options=nil|
              DSL::Helper.add_constructed_definition(
                self,
                Definitions::SequenceOf,
                type: type,
                name: name,
                options: options
              )
            end
          end

          define_method :declare_set_of do
            define_method :asn1_set_of do |name, type, options=nil|
              DSL::Helper.add_constructed_definition(
                self,
                Definitions::SetOf,
                type: type,
                name: name,
                options: options
              )
            end
          end

          define_method :declare_any do
            define_method :asn1_any do |name, options=nil|
              DSL::Helper.add_constructed_definition(
                self,
                Definitions::Any,
                name: name,
                options: options
              )
            end
          end
        end

        init_methods
      end

    end
  end
end

