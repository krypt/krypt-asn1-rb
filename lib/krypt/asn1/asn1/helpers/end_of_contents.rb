module Krypt::ASN1
  module Helpers
    module EndOfContents

      module_function

      def add_eoc(values, io)
        Krypt::ASN1::EndOfContents.new.encode_to(io) if needs_eoc?(values)
      end

      private; module_function

      def needs_eoc?(values)
        # just add if it was not present in the values
        last = values.last
        !(last && eoc?(last))
      end

      def eoc?(last)
        last.tag == END_OF_CONTENTS && last.tag_class == Der::TagClass::UNIVERSAL
      end

    end
  end
end

