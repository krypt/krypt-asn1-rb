require_relative 'parsers/constructed'
require_relative 'parsers/constructed_of'
require_relative 'parsers/object'
require_relative 'parsers/primitive'

module Krypt::Asn1
  module DSL

    module Parser

      def parse(io_or_string)
        from_asn1(Krypt::Asn1.parse(io_or_string))
      end
      alias_method :decode, :parse

      def from_asn1(asn1)
        definition = instance_variable_get(:@definition)
        obj = allocate
        definition.parse(asn1, obj)
        obj.instance_variable_set(:@asn1, asn1)
        obj
      end

    end

  end
end
