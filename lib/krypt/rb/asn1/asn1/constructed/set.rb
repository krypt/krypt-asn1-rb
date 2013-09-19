module Krypt::Rb::Asn1
  class Set < Constructed

    def initialize(options)
      super(options)
      unless options[:tag]
        @tag = Der::Tag::SEQUENCE
      end
    end

    def encode_value(values)
      # TODO
    end
    
  end
end

