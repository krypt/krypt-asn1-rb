module Krypt::ASN1
  module DSL
    module Choice
      def self.included(base)
        base.instance_variable_set(
          :@definition,
          Definitions::Choice::Root.new
        )

        [
          Definitions::Choice::ClassMethods,
          Parser
        ].each { |mod| base.extend(mod) }

        [
          Definitions::Choice::Accessor,
          Encoder,
          Presenter
        ].each { |mod| base.include(mod) }
      end
    end
  end
end

