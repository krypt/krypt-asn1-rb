# encoding: BINARY

module Krypt::Asn1
  class Der
    include IOEncodable

    attr_reader :tag, :length, :value

    def initialize(options_or_tag, length=nil, value=nil)
      if length
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

    private

    def init_options(options)
      @tag = Der::Tag.new(options)
      @value = options[:value]
      init_length(options)
    end

    def init_length(options)
      @length = if options[:indefinite]
        Der::Length.new(indefinite: true)
      else
        Der::Length.new(length: @value.size)
      end
    end

  end
end

