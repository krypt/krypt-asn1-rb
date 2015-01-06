module Krypt::Asn1
  class LazyParseablePrimitive

    def initialize(der, parser)
      @der = der
      @parser = parser
    end

    def tag
      @der.tag
    end

    def length
      @der.length
    end

    def value
      @der.value
    end

    def parsed_value
      parse_value unless defined?(@parsed_value)
      @parsed_value
    end

    def encode_to(io)
      @der.encode_to(io)
    end

    private

    def parse_value
      @parsed_value = @parser.parse_value(@der.value)
      remove_instance_variable(:@parser)
    end

  end
end
