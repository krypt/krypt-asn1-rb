module Krypt::Asn1
  class Set < Constructed

    def encode_value(values)
      # TODO
    end

    def default_tag
      Der::Tag::SEQUENCE
    end
    
  end
end

