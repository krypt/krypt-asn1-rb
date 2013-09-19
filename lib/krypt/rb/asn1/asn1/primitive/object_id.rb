# encoding: BINARY

module Krypt::Rb::Asn1
  class ObjectId < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::OBJECT_ID
      end
    end
    
    def parse_value(bytes)
      # TODO
    end

    def encode_value(value)
      # TODO
    end

  end
end

