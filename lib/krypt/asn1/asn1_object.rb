require_relative 'io_encodable'

module Krypt::Asn1::Rb
  class Asn1Object

    attr_reader :tag, :length, :value

    def initialize(options_or_tag, length=nil, value=nil)
      if options_or_tag.respond_to?(:tag)
        @tag = options_or_tag
        @length = length
        @value = value
      else
        init_options(options_or_tag)
      end
    end

    def encode_to(io)
      @tag.encode_to(io)
      @length.encode_to(io)
      io << @value
    end

    def encoding
      # using String.new forces BINARY encoding of the StringIO
      StringIO.new(String.new).tap do |io|
        encode_to(io)
      end.string
    end

    private

    def init_options(options)
      @tag = Tag.new(options)
      @value = options[:value]
      init_length(options)
    end

    def init_length(options)
      if options[:indefinite]
        @length = Length.new(indefinite: true)
      else
        @length = Length.new(length: @value.bytesize)
      end
    end

  end
end

