module Krypt::Rb::Asn1
  class Sequence < Constructed

    def initialize(options)
      super(options)
      unless options[:tag]
        @tag = Der::Tag::SEQUENCE
      end
    end
    
  end
end

