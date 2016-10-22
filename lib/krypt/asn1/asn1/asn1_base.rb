module Krypt::ASN1
  class ASN1Base
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
      StringIO.new(String.new).tap do |io|
        encode_to(io)
      end.string
    end

    def encode_to(io)
      @asn1.encode_to(io)
    end

    def <=>(other)
      return nil unless other.respond_to?(:to_der)
      Comparator.compare(self, other)
    end

    def to_s
      DisplayVisitor.new.tap do |visitor|
        accept(visitor)
      end.to_s
    end
  end
end

