# encoding: BINARY

module Krypt::Asn1
  class Der

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

    def to_der
      Der::Encoder.to_der(self)
    end

    def encode_to(io)
      Der::Encoder.encode_to(io, self)
    end

    class << self

      def decode(io_or_string)
        header = Der::Parser.new(io_or_string).next_header
        raise "Already at EOF" unless header
        Der.new(header.tag, header.length, header.value)
      end
      alias_method :parse, :decode

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

