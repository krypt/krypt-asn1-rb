module Krypt::Asn1
  module Helpers
    module EndOfContents

      module_function

      def add_eoc(values, io)
        last = values.last
        # just add if it was not present in the values
        needs_eoc = last.nil? ||
                    !(
                      last.tag == END_OF_CONTENTS &&
                      last.tag_class == Der::TagClass::UNIVERSAL
                    )

        Krypt::Asn1::EndOfContents.new.encode_to(io) if needs_eoc
      end

    end
  end
end
