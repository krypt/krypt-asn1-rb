require_relative 'dsl/asn1_object'
require_relative 'dsl/encoders'
require_relative 'dsl/parsers'
require_relative 'dsl/definitions'

module Krypt::Asn1
  module DSL

    module Sequence
      def self.included(base)
        Helper.create_constructed_definition(base, nil)
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
        Helper.create_constructed_definition(base, nil)
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
        base.instance_variable_set(
          :@definition,
          Definitions::Choice::Root.new
        )

        [
          Definitions::Choice::Accessor,
          Definitions::ConstructedClassMethods,
          Parsers::Choice
        ].each { |mod| base.extend(mod) }

        base.include(Encoders::Choice)

        [:tag, :type].each { |field| base.attr_reader field }
      end
    end

    module Helper

      module_function

      def create_constructed_definition(base, encoder)
        base.instance_variable_set(
          :@definition,
          Definitions::Constructed::Root.new
        )

        [
          Definitions::Constructed::Accessor,
          Definitions::Constructed::ClassMethods,
          Parsers::Constructed
        ].each { |mod| base.extend(mod) }

        base.include(Encoders::Constructed)
      end
    end

  end
end

