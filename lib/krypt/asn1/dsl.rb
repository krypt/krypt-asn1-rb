require_relative 'dsl/helper'
require_relative 'dsl/asn1_object'
require_relative 'dsl/accessors'
require_relative 'dsl/encoder'
require_relative 'dsl/parser'
require_relative 'dsl/definitions'

module Krypt::Asn1
  module DSL

    module Sequence
      extend Helper

      def self.included(base)
        create_constructed_definition(base, nil)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def default_tag
          SEQUENCE
        end
      end
    end

    module Set
      extend Helper

      def self.included(base)
        create_constructed_definition(base, nil)
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
        #  Definitions::Root.new(
        #    parser: nil,
        #    encoder: nil
        #  )
        #)

        #[
        #  Accessors::Constructed,
        #  Definitions::ConstructedClassMethods,
        #  Parser,
        #  Encoder
        #].each { |mod| base.extend(mod) }
        #
        #
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

