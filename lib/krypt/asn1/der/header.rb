module Krypt::Asn1
  class Der::Header

    attr_reader :tag, :length

    def initialize(tag, length, parser)
      @tag = tag
      @length = length
      @parser = parser
    end

    def value
      read_value
      @value
    end

    def value_io
      @reader ||= @parser.value_parser(self)
    end

    private

    def read_value
      return if defined?(@value)
      @value = value_io.read
    end

  end
end

