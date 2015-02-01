module Krypt::Asn1
  module DSL
    module Definitions
      class BaseConstructedDefinition

        attr_reader :name, :options, :codec

        def initialize(options)
          @name = options.fetch(:name)
          @options = options.fetch(:options)
          @codec = options.fetch(:codec)
        end

      end
    end
  end
end
