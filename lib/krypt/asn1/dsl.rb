require_relative 'dsl/asn1_object'
require_relative 'dsl/definitions'
require_relative 'dsl/encoder'
require_relative 'dsl/parser'
require_relative 'dsl/presenter'

require_relative 'dsl/choice'
require_relative 'dsl/sequence'
require_relative 'dsl/sequence_of'
require_relative 'dsl/set'
require_relative 'dsl/set_of'

module Krypt::Asn1
  module DSL

    module Helper

      module_function

      def create_constructed_definition(base, encoder)
        base.instance_variable_set(
          :@definition,
          Definitions::Constructed::Root.new(base.default_tag)
        )

        [
          Definitions::Constructed::Accessor,
          Definitions::Constructed::ClassMethods,
          Parser
        ].each { |mod| base.extend(mod) }

        [ Encoder, Presenter ].each { |mod| base.include(mod) }
      end

      def create_constructed_of_definition(base, encoder)
        base.instance_variable_set(
          :@definition,
          Definitions::ConstructedOf::Root.new(base.default_tag)
        )

        [
          Definitions::ConstructedOf::ClassMethods,
          Parser
        ].each { |mod| base.extend(mod) }

        [
          Definitions::ConstructedOf::Accessor,
          Encoder,
          Presenter
        ].each { |mod| base.include(mod) }
      end
    end

  end
end

