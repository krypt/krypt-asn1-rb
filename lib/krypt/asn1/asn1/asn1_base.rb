# encoding: BINARY

module Krypt::Asn1
  class Asn1Base
    include Comparable

    def self.default_tag; nil; end

    def tag
      @asn1.tag
    end

    def length
      @asn1.length
    end

    def value
      @asn1.parsed_value
    end

    def der_value
      @asn1.value
    end

    def to_der
      io = StringIO.new(String.new)
      encode_to(io)
      io.string
    end

    def encode_to(io)
      @asn1.encode_to(io)
    end

    def <=>(other)
      return nil unless other.respond_to?(:to_der)
      Comparator.compare(self, other)
    end

    def to_s
      visitor = DisplayVisitor.new
      accept(visitor)
      visitor.to_s
    end
  end
end

