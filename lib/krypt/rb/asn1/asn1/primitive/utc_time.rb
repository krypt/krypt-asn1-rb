# encoding: BINARY

module Krypt::Rb::Asn1
  class UtcTime < Primitive

    def initialize
      super(options)
      unless options[:tag]
        @tag = Der::Tag::UTC_TIME
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

