# encoding: BINARY

module Krypt::Asn1
  class Asn1Base
    include IOEncodable
    include Comparable

    def ==(other)
      return false unless other.respond_to?(:to_der)
      to_der == other.to_der
    end

    def <=>(other)
      return nil unless other.respond_to?(:to_der)
      Comparator.compare(to_der, other.to_der)
    end

  end
end

