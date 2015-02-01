require_relative 'parsers/constructed'
require_relative 'parsers/primitive'

module Krypt::Asn1
  module DSL

    module Parser

      def parse(io_or_string)
        asn1 = Krypt::Asn1.parse(io_or_string)
        definition = instance_variable_get(:@definition)
        obj = allocate
        definition.parse(asn1, obj)
        obj.instance_variable_set(:@asn1, asn1)
        obj
      end
      alias_method :decode, :parse

    end

  end
end
