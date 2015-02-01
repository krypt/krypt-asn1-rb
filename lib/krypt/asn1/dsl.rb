require_relative 'dsl/accessors'
require_relative 'dsl/codecs'
require_relative 'dsl/definitions'
require_relative 'dsl/encoder'
require_relative 'dsl/parser'

module Krypt::Asn1
  module DSL

    module Helper
      module_function

      def init_cons_definition(base, codec)
        base.instance_variable_set(
          :@definition,
          Definitions::Object.new(codec: codec)
        )

        [
          Accessors::Default,
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
        Helper.init_cons_definition(base, Codecs::Sequence)
      end
    end

    module Set
      def self.included(base)
        Helper.init_cons_definition(base, Codecs::Set)
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
          base.asn1_attr_accessor field
        end
      end
    end

  end
end

