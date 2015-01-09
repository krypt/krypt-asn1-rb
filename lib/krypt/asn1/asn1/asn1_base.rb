# encoding: BINARY

module Krypt::Asn1
  class Asn1Base
    include IOEncodable
    include Comparable

    class DisplayVisitor
      def visit_constructed(constructed)
        puts "Cons: #{constructed.inspect}"
      end

      def visit_primitive(primitive)
        puts "Prim: #{primitive.inspect}"
      end
    end

    def ==(other)
      return false unless other.respond_to?(:to_der)
      to_der == other.to_der
    end

    def <=>(other)
      return nil unless other.respond_to?(:to_der)
      Comparator.compare(to_der, other.to_der)
    end

    def dump
      accept(DisplayVisitor.new)
    end
  end
end

