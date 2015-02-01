require_relative 'dsl/accessors'
require_relative 'dsl/definitions'
require_relative 'dsl/encoder'
require_relative 'dsl/parser'

module Krypt::Asn1
  module DSL

    module Helper
      module_function

      def init_cons_definition(base, encoder)
        base.instance_variable_set(
          :@definition,
          Definitions::Object.new(
            parser: Parsers::Constructed,
            encoder: encoder
          )
        )

        [
          Accessors::Constructed,
          Definitions::ConstructedClassMethods,
          Parser,
          Encoder
        ].each { |mod| base.extend(mod) }
      end

      def add_to_definition(klass, field_definition)
        definition = klass.instance_variable_get(:@definition)
        definition.add(field_definition)
      end

    end

    module Sequence
      def self.included(base)
        Helper.init_cons_definition(base, nil)
      end
    end

    module Set
      def self.included(base)
        Helper.init_cons_definition(base, nil)
      end
    end

    module Choice
      def self.included(base)
        base.instance_variable_set(
          :@definition,
          Definitions::ObjectChoice.new
        )

        [
          Accessors::Choice,
          Definitions::ChoiceClassMethods,
          Parser,
          Encoder
        ].each { |mod| base.extend(mod) }

        [:value, :tag, :type].each do |field|
          base.asn1_attr_reader field
        end
      end
    end

  end
end

