module Krypt::Asn1
  module DSL
    module Definitions

      module Constructed
        extend Shared

        class << self
          define_method :declare_prim do |meth, type|
            define_method meth do |name, opts=nil|
              asn1_attr_accessor name

              DSL::Helper.add_to_definition(
                self,
                codec: Codecs::Primitive,
                type: type,
                name: name,
                options: opts
              )
            end
          end

          define_method :declare_special_typed do |meth, codec|
            define_method meth do |name, type, opts=nil|
              asn1_attr_accessor name

              DSL::Helper.add_to_definition(
                self,
                codec: codec,
                type: type,
                name: name,
                options: opts
              )
            end
          end

          define_method :declare_any do
            define_method :asn1_any do |name, opts=nil|
              asn1_attr_accessor name

              DSL::Helper.add_to_definition(
                self,
                codec: Codecs::Any,
                name: name,
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

