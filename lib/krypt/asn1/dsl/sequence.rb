module Krypt::ASN1
  module DSL

    module Sequence
      def self.included(base)
        base.extend(ClassMethods)
        Helper.create_constructed_definition(base, nil)
      end

      module ClassMethods
        def default_tag
          SEQUENCE
        end
      end
    end
  end
end

