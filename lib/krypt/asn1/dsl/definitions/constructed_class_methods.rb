module Krypt::Asn1
  module DSL
    module Definitions

      module ConstructedClassMethods
        extend SharedClassMethods

        class << self
          define_method :declare_primitive do |method, type|
            define_method method do |name, options=nil|
              definition = Definitions::Primitive.new(
                type: type,
                name: name,
                options: options
              )
              DSL::Helper.add_to_definition(
                self,
                definition
              )

              asn1_attr_reader name, definition.iv_name
            end
          end

          define_method :declare_constructed do |method, parser, encoder|
            define_method method do |name, type, options=nil|
              definition = Definitions::Constructed.new(
                parser: parser,
                encoder: encoder,
                type: type,
                name: name,
                options: options
              )
              DSL::Helper.add_to_definition(
                self,
                definition
              )

              asn1_attr_reader name, definition.iv_name
            end
          end

          define_method :declare_any do
            define_method :asn1_any do |name, options=nil|
              definition = Definitions::Any.new(
                name: name,
                options: options
              )
              DSL::Helper.add_to_definition(
                self,
                definition
              )

              asn1_attr_reader name, definition.iv_name
            end
          end
        end

        init_methods
      end

    end
  end
end

