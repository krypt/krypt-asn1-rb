module Krypt::Asn1
  class ObjectId < Primitive

    def default_tag
      OBJECT_ID
    end

  end
end

