module Krypt::ASN1
  class ObjectId < Primitive

    def self.default_tag
      OBJECT_ID
    end

  end
end

