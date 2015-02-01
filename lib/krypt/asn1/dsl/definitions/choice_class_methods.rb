module Krypt::Asn1
  module DSL
    module Definitions

      module ChoiceClassMethods
        extend SharedClassMethods

        class << self
          define_method :declare_primitive do |method, type|
            define_method method do |options=nil|
              DSL::Helper.add_to_definition(
                self,
                Definitions::PrimitiveChoice.new(
                  type: type,
                  options: options
                )
              )
            end
          end

          define_method :declare_constructed do |method, parser, encoder|
            define_method method do |type, options=nil|
              DSL::Helper.add_to_definition(
                self,
                Definitions::ConstructedChoice.new(
                  parser: parser,
                  encoder: encoder,
                  type: type,
                  options: options
                )
              )
            end
          end

          define_method :declare_any do
            define_method :asn1_any do |options=nil|
              DSL::Helper.add_to_definition(
                self,
                Definitions::AnyChoice.new(options: options)
              )
            end
          end
        end

        init_methods
      end

    end
  end
end
