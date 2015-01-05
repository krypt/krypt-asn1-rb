module Krypt::Asn1
  module DSL
    module Definitions

      module Choice
        extend Shared

        class << self
          define_method :declare_prim do |meth, type|
            define_method meth do |opts=nil|
              DSL::Helper.add_to_definition(
                self,
                codec: Codecs::Primitive,
                type: type,
                options: opts
              )
            end
          end

          define_method :declare_special_typed do |meth, codec|
            define_method meth do |type, opts=nil|
              DSL::Helper.add_to_definition(
                self,
                codec: codec,
                type: type,
                options: opts
              )
            end
          end

          define_method :declare_any do
            define_method :asn1_any do |opts=nil|
              DSL::Helper.add_to_definition(
                self,
                codec: Codecs::Any,
                options: opts
              )
            end
          end
        end

        init_methods
      end

    end
  end
end
