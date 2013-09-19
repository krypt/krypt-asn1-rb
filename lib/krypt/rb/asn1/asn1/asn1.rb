module Krypt::Rb::Asn1
  class Asn1
    include IOEncodable

    attr_reader :tag, :tag_class

    def initialize(options)
      @tag = options[:tag]
      @tag_class = options[:tag_class] || :UNIVERSAL
      @value = options[:value]
      @constructed = !!options[:constructed]
      @indefinite = !!options[:indefinite]
    end

    def indefinite?; @indefinite; end

    def constructed?; @constructed; end

    def value
      unless defined?(@value)
        @value = parse_value(@der.value)
      end
      @value
    end

    def encode_to(io)
      unless defined?(@der) 
        @der = create_der
      end
      @der.encode_to(io)
    end

    class << self

      def from_der(der)
        obj = allocate
        obj.instance_eval do
          t = der.tag
          @tag = t.tag
          @tag_class = t.tag_class.tag_class
          @indefinite = der.length.indefinite?
          @constructed = t.constructed?
          @der = der
        end
        obj
      end

    end

    private

    def create_der
      tag = Der::Tag.new(tag: @tag, tag_class: @tag_class, constructed: @constructed)
      value = encode_value(@value)
      length = Der::Length.new(length: value ? value.size : 0, indefinite: @indefinite)
      Der.new(tag, length, value)
    end

  end
end

