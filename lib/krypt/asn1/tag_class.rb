module Krypt::Asn1::Rb
  class TagClass

    attr_reader :tag_class, :mask

    UNIVERSAL = 0x00
    APPLICATION = 0x40
    CONTEXT_SPECIFIC = 0x80
    PRIVATE = 0xc0

    def initialize(tag_class, mask)
      @tag_class = tag_class
      @mask = mask
    end

    def to_sym
      @tag_class
    end


    class << self
      
      def of(tag_class)
        self.new(tag_class, determine_mask(tag_class))
      end

      def of_mask(mask)
        case mask
        when UNIVERSAL then :UNIVERSAL
        when APPLICATION then :APPLICATION
        when CONTEXT_SPECIFIC then :CONTEXT_SPECIFIC
        when PRIVATE then :PRIVATE
        else
          raise "Unknown tag class: #{mask}"
        end
      end

      private

      def determine_mask(tc)
        if tc == :IMPLICIT || tc == :EXPLICIT
          CONTEXT_SPECIFIC
        else
          const_get(tc)
        end
      end

    end

  end
end
