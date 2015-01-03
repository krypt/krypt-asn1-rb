module Krypt::Asn1
  class Sequence < Constructed

    def self.default_tag
      SEQUENCE
    end

    def sort_values(values)
      values
    end

  end
end

