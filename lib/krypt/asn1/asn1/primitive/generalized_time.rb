module Krypt::Asn1
  class GeneralizedTime < Primitive

    def self.default_tag
      GENERALIZED_TIME
    end

  end
end

