module Krypt::Asn1
  class Sequence < Constructed

    def default_tag
      Asn1::SEQUENCE
    end
    
  end
end

