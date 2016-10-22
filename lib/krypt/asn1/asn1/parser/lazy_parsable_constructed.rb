module Krypt::ASN1
  module Parser
    class LazyParsableConstructed

      attr_reader :tag, :length

      def initialize(der)
        @tag = der.tag
        @length = der.length
        @der_value = der.value
      end

      def value
        @der_value || create_value
      end

      def parsed_value
        @values ||= parse_values
      end

      def encode_to(io)
        if defined?(@der_value)
          cached_encode_to(io)
        else
          default_encode_to(io)
        end
      end

      private

      def parse_values
        [].tap do |objects|
          io = StringIO.new(@der_value)

          while object = Krypt::ASN1::Parser.parse(io)
            objects << object
          end

          # do not include END_OF_CONTENT
          objects.pop if @length.indefinite?
          # erase the cached encoding
          remove_instance_variable(:@der_value)
        end
      end

      def cached_encode_to(io)
        io << @tag.encoding
        io << @length.encoding
        io << @der_value
      end

      def default_encode_to(io)
        io << @tag.encoding
        io << @length.encoding
        encode_values_to(io, @length.indefinite?)
      end

      def encode_values_to(io, indefinite)
        @parsed_value.each { |v| v.encode_to(io) }
        Helpers::EndOfContents.add_eoc(@parsed_value, io) if indefinite
      end

    end
  end
end

