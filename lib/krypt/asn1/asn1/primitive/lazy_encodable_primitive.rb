module Krypt::Asn1
  class LazyEncodablePrimitive

    attr_reader :tag, :parsed_value

    def initialize(tag, tag_class, value, encoder)
      @tag = Der::Tag.new(tag: tag, tag_class: tag_class)
      @value = value
      @encoder = encoder
    end

    def length
      create_der
      @der.length
    end

    def value
      create_der
      @der.value
    end

    def parsed_value
      @value
    end

    def encode_to(io)
      create_der
      @der.encode_to(io)
    end

    private

    def create_der
      return if defined?(@der)

      value = @encoder.encode_value(@value)
      length = Der::Length.new(length: value ? value.size : 0)
      @der = Der.new(@tag, length, value)
      remove_instance_variable(:@encoder)
    end

  end
end
