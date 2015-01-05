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
          codec: codec,
          layout: [],
          min_size: 0
        )

        [
          Accessors::Default,
          Definitions::Constructed,
          Parser,
          Encoder
        ].each { |mod| base.extend(mod) }
      end

      def add_to_definition(klass, new_def)
        definition = klass.instance_variable_get(:@definition)
        definition[:layout] << new_def
        codec = definition[:codec]
        if codec == Codecs::Sequence || codec == Codecs::Set
          increase_min_size(definition, new_def[:options])
        end
        nil
      end

      private; module_function

      def increase_min_size(definition, options)
        options ||= {}
        need_increase = !(definition[:optional] || definition[:default])
        definition[:min_size] += 1 if need_increase
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
          codec: Codecs::Choice,
          layout: []
        )

        [
          Accessors::Choice,
          Definitions::Choice,
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

