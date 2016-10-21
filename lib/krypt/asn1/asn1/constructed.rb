module Krypt
  module Asn1
    class Constructed < Asn1Base
      include Enumerable

      def initialize(values, options={})
        @asn1 = Asn1::Encoder.new_encodable_constructed(self, values, options)
      end

      def each(&block)
        value.each(&block)
      end

      def size
        value.size
      end

      def accept(visitor)
        visitor.pre_constructed(self)
        each { |v| v.accept(visitor) }
        visitor.post_constructed(self)
      end

      class << self

        def from_der(der)
          allocate.tap do |obj|
            asn1 = Asn1::Parser.new_parsable_constructed(obj, der)
            obj.instance_variable_set(:@asn1, asn1)
          end
        end

      end

    end
  end
end

require_relative 'constructed/sequence'
require_relative 'constructed/set'

