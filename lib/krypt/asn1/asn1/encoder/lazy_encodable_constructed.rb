module Krypt::ASN1
  module Encoder
    class LazyEncodableConstructed

      attr_reader :tag, :parsed_value

      def initialize(object, values, options)
        t = options[:tag] || object.class.default_tag
        tc = options[:tag_class] || Der::TagClass::UNIVERSAL
        @tag = Der::Tag.new(tag: t, tag_class: tc, constructed: true)
        @parsed_value = values

        if options[:indefinite]
          @length = Der::Length.new(indefinite: true)
        end
      end

      def length
        @length ||= create_length
      end

      def value
        create_value
      end

      def encode_to(io)
        if defined?(@length)
          default_encode_to(io)
        else
          first_definite_encode_to(io)
        end
      end

      def encode_values_to(io, indefinite)
        @parsed_value.each { |v| v.encode_to(io) }
        Helpers::EndOfContents.add_eoc(@parsed_value, io) if indefinite
      end

      private

      def create_length
        value = create_value
        Der::Length.new(length: value.size)
      end

      def create_value
        value_io = StringIO.new(String.new)
        encode_values_to(value_io, false)
        value_io.string
      end

      def default_encode_to(io)
        io << @tag.encoding
        io << @length.encoding
        encode_values_to(io, @length.indefinite?)
      end

      def first_definite_encode_to(io)
        value = create_value
        @length = Der::Length.new(length: value.size)
        io << @tag.encoding
        io << @length.encoding
        io << value
      end

    end
  end
end

