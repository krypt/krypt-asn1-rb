# encoding: BINARY

module Krypt::Asn1
  class Constructed < Asn1Base
    include Enumerable

    attr_reader :tag

    def initialize(values, options={})
      t = options[:tag] || self.class.default_tag
      tc = options[:tag_class] || Der::TagClass::UNIVERSAL
      @tag = Der::Tag.new(tag: t, tag_class: tc, constructed: true)
      @values = values

      if options[:indefinite]
        @length = Der::Length.new(indefinite: true)
      else
        @indefinite = false
      end
    end

    def length
      @length ||= create_length
    end

    def value
      parse_values
      @values
    end

    def encode_to(io)
      if defined?(@der_value)
        encode_cached_to(io)
      else
        encode_tlv_to(io)
      end
    end

    def each(&block)
      value.each(&block)
    end

    def accept(visitor)
      visitor.visit_constructed(self)
      each { |v| v.accept(visitor) }
    end

    class << self

      def from_der(der)
        obj = allocate
        obj.instance_eval do
          @tag = der.tag
          @length = der.length
          @der_value = der.value
          @parsed = true
        end
        obj
      end

    end

    protected

    def parsed?; @parsed; end

    def sort_values(values)
      values.to_a
    end

    private

    def create_length
      return if defined?(@length)
      value = create_value
      Der::Length.new(length: value.size)
    end

    def create_value
      value_io = StringIO.new(String.new)
      encode_values_to(value_io, false)
      value_io.string
    end

    def parse_values
      return if defined?(@values)
      parser = Parser.new
      objects = []
      io = StringIO.new(@der_value)

      while object = parser.parse(io)
        objects << object
      end

      # do not include END_OF_CONTENT
      objects.pop if @length.indefinite?
      # erase the cached encoding
      remove_instance_variable(:@der_value)
      @values = objects
    end

    def encode_cached_to(io)
      io << @tag.encoding
      io << @length.encoding
      io << @der_value
    end

    def encode_tlv_to(io)
      io << @tag.encoding
      if @length
        io << @length.encoding
        encode_values_to(io, length.indefinite?)
      else
        @length = encode_lv_to(io)
      end
    end

    def encode_lv_to(io)
      value = create_value
      length = Der::Length.new(length: value.size)
      io << length.encoding
      io << value
      length
    end

    def encode_values_to(io, indefinite)
      sorted = sort_values(value)
      sorted.each { |v| v.encode_to(io) }
      add_eoc(sorted, io) if indefinite
    end

    def add_eoc(values, io)
      last = values.last
      # just add if it was not present in the values
      needs_eoc = last.nil? ||
                  !(
                    last.tag == END_OF_CONTENTS &&
                    last.tag_class == Der::TagClass::UNIVERSAL
                  )

      EndOfContents.new.encode_to(io) if needs_eoc
    end

  end
end

require_relative 'constructed/sequence'
require_relative 'constructed/set'

