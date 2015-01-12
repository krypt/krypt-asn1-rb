module Krypt::Asn1
  module Encoder
    class LazyEncodablePrimitive

      attr_reader :tag, :parsed_value

      def initialize(object, value, options)
        tag = options[:tag] || object.class.default_tag
        tag_class = options[:tag_class] || Der::TagClass::UNIVERSAL
        @tag = Der::Tag.new(tag: tag, tag_class: tag_class)
        @parsed_value = value
        @object = object
      end

      def length
        create_der
        @der.length
      end

      def value
        create_der
        @der.value
      end

      def encode_to(io)
        create_der
        @der.encode_to(io)
      end

      private

      def create_der
        return if defined?(@der)

        value = Encoder.encode_value(@object, @parsed_value)
        length = Der::Length.new(length: value ? value.size : 0)
        @der = Der.new(@tag, length, value)
      end

    end
  end
end
