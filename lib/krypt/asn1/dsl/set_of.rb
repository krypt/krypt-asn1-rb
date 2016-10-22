module Krypt::ASN1
  module DSL

    module SetOf
      def self.included(base)
        base.extend(ClassMethods)
        Helper.create_constructed_of_definition(base, nil)
      end

      module ClassMethods
        def default_tag
          SET
        end
      end
    end
  end
end

