module Krypt::Asn1
  module DSL

    module Sequence
      def self.included(base)
        Helper.create_constructed_definition(base, nil)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def default_tag
          SEQUENCE
        end
      end
    end
  end
end

