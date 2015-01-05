module Krypt::Asn1
  class Primitive < Asn1Base

    def initialize(value, options={})
      @tag = options[:tag] || self.class.default_tag
      @tag_class = options[:tag_class] || Der::TagClass::UNIVERSAL
      @value = value
    end

    def indefinite?; false; end

    def constructed?; false; end

    def tag
      defined?(@der) ? @der.tag.tag : @tag
    end

    def tag_class
      defined?(@der) ? @der.tag.tag_class : @tag_class
    end

    def value
      unless defined?(@value)
        @value = parse_value(@der.value)
      end
      @value
    end

    def encode_to(io)
      create_der unless defined?(@der)
      @der.encode_to(io)
    end

    class << self

      def from_der(der)
        obj = allocate
        obj.instance_eval { @der = der }
        obj
      end

      def of(value)
        new(value)
      end

    end

    protected

    def parse_value(bytes)
      bytes
    end

    def encode_value(value)
      value
    end

    private

    def create_der
      tag = Der::Tag.new(tag: @tag, tag_class: @tag_class)
      value = encode_value(@value)
      length = Der::Length.new(length: value ? value.size : 0)
      remove_instance_variable(:@tag)
      remove_instance_variable(:@tag_class)
      @der = Der.new(tag, length, value)
    end

  end
end

require_relative 'primitive/end_of_contents'
require_relative 'primitive/boolean'
require_relative 'primitive/integer'
require_relative 'primitive/bit_string'
require_relative 'primitive/octet_string'
require_relative 'primitive/null'
require_relative 'primitive/object_id'
require_relative 'primitive/enumerated'
require_relative 'primitive/utf8_string'
require_relative 'primitive/numeric_string'
require_relative 'primitive/printable_string'
require_relative 'primitive/t61_string'
require_relative 'primitive/videotex_string'
require_relative 'primitive/ia5_string'
require_relative 'primitive/utc_time'
require_relative 'primitive/generalized_time'
require_relative 'primitive/graphic_string'
require_relative 'primitive/iso64_string'
require_relative 'primitive/general_string'
require_relative 'primitive/universal_string'
require_relative 'primitive/character_string'
require_relative 'primitive/bmp_string'

