module Krypt::Asn1
  class Der::Header

    attr_reader :tag, :length

    def initialize(tag, length, header_parser)
      @tag = tag
      @length = length
      @parser = header_parser
    end

    def create_der
      Der.new(@tag, @length, value)
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
        Der::IndefiniteReader.new(@parser)
      else
        Der::DefiniteReader.new(@parser.io, @length.length)
      end
    end

    def read_value
      @value = value_io.read
    end

  end
end

