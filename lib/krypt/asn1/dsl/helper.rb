module Krypt::Asn1
  module DSL
    module Helper

      module_function

      def create_constructed_definition(base, encoder)
        base.instance_variable_set(
          :@definition,
          Definitions::Root.new(
            parser: Parsers::Constructed,
            encoder: encoder
          )
        )

        [
          Accessors::Constructed,
          Definitions::Constructed::ClassMethods,
          Parser,
          Encoder
        ].each { |mod| base.extend(mod) }
      end

      def add_definition(klass, definition_class, options)
        field_definition = definition_class.new(options)
        definition = klass.instance_variable_get(:@definition)
        definition.add(field_definition)
        klass.asn1_attr_reader(field_definition.name, field_definition.iv_name)
      end

    end
  end
end

