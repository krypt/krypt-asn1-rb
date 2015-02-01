module Krypt::Asn1
  module DSL
    module Definitions

      module ConstructedClassMethods
        extend SharedClassMethods

        class << self
          define_method :declare_primitive do |method, type|
            define_method method do |name, options=nil|
              asn1_attr_accessor name

              DSL::Helper.add_to_definition(
                self,
                Definitions::Primitive.new(
                  type: type,
                  name: name,
                  options: options
                )
              )
            end
          end

          define_method :declare_constructed do |method, codec|
            define_method method do |name, type, options=nil|
              asn1_attr_accessor name

              DSL::Helper.add_to_definition(
                self,
                Definitions::Constructed.new(
                  codec: codec,
                  type: type,
                  name: name,
                  options: options
                )
              )
            end
          end

          define_method :declare_any do
            define_method :asn1_any do |name, options=nil|
              asn1_attr_accessor name

              DSL::Helper.add_to_definition(
                self,
                Definitions::Any.new(
                  name: name,
                  options: options
                )
              )
            end
          end
        end

        init_methods
      end

    end
  end
end

