module Krypt::Asn1
  module DSL
    module Definitions
      class BaseChoiceDefinition

        attr_reader :options, :codec

        def initialize(options)
          @options = options.fetch(:options)
          @codec = options.fetch(:codec)
        end

      end
    end
  end
end
