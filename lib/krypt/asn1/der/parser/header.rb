module Krypt::Asn1
  class Der::Header

    attr_reader :tag, :length

    def initialize(tag, length, io)
      @tag = tag
      @length = length
      @io = io
    end

    def value
      read_value
      @value
    end

    def value_io
      @reader ||= new_reader
    end

    private

    def new_reader
      if @length.indefinite?
        Der::IndefiniteReader.new(@io)
      else
        Der::DefiniteReader.new(@io, @length.length)
      end
    end

    def read_value
      return if defined?(@value)
      @value = value_io.read
    end

  end
end

