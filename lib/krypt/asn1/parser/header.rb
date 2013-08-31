module Krypt::Asn1::Rb
  class Header

    attr_reader :tag, :length

    def initialize(tag, length, header_parser)
      @tag = tag
      @length = length
      @parser = header_parser
    end

    def asn1_object
      Asn1Object.new(@tag, @length, value)
    end

    def value
       defined?(@value) ? @value : read_value
    end

    def value_io
      @reader || new_reader
    end

    private

    def new_reader
      @reader = if @length.indefinite?
        IndefiniteReader.new(@parser)
      else
        DefiniteReader.new(@parser.io, @length.length)
      end
    end

    def read_value
      @value = value_io.read
    end

  end
end

