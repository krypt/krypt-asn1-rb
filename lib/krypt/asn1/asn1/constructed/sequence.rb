module Krypt::Asn1
  class Sequence < Constructed

    def default_tag
      Der::Tag::SEQUENCE
    end
    
  end
end

