require_relative 'dsl/asn1_object'
require_relative 'dsl/accessors'
require_relative 'dsl/encoder'
require_relative 'dsl/parser'
require_relative 'dsl/definitions'

module Krypt::Asn1
  module DSL

    module Helper
      module_function

      def init_cons_definition(base, encoder)
        base.instance_variable_set(
          :@definition,
          Definitions::Root.new(
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

      def add_constructed_definition(klass, definition_class, options)
        field_definition = definition_class.new(options)
        definition = klass.instance_variable_get(:@definition)
        definition.add(field_definition)
        klass.asn1_attr_reader(field_definition.name, field_definition.iv_name)
      end

    end

    module Sequence
      def self.included(base)
        Helper.init_cons_definition(base, nil)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def default_tag
          SEQUENCE
        end
      end
    end

    module Set
      def self.included(base)
        Helper.init_cons_definition(base, nil)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def default_tag
          SET
        end
      end
    end

    module Choice
      def self.included(base)
        #base.instance_variable_set(
        #  :@definition,
        #  Definitions::RootChoice.new
        #)

        #[
        #  Accessors::Choice,
        #  Definitions::ChoiceClassMethods,
        #  Parser,
        #  Encoder
        #].each { |mod| base.extend(mod) }

        #[:value, :tag, :type].each do |field|
        #  base.asn1_attr_reader field
        #end
      end
    end

  end
end

