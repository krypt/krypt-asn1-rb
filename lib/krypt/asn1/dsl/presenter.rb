module Krypt::ASN1
  module DSL
    module Presenter

      def to_s
        return to_s unless @asn1
        @asn1.to_s
      end

    end
  end
end
