module Krypt::Asn1
  module DSL

    module SetOf
      def self.included(base)
        Helper.create_constructed_of_definition(base, nil)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def default_tag
          SET
        end
      end
    end
  end
end

