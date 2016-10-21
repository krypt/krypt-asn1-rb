module Krypt::Asn1
  module DSL
    class Asn1Object

      attr_reader :value

      def initialize(value)
        @value = value
      end

      class << self
        def parse(io_or_string)
          from_asn1(Krypt::Asn1.parse(io_or_string))
        end
        alias_method :decode, :parse

        def from_asn1(asn1)
          new(asn1)
        end
      end
    end
  end
end
