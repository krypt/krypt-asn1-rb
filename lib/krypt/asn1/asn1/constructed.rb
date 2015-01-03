# encoding: BINARY

module Krypt::Asn1
  class Constructed < Asn1Base

    def initialize(value, options={})
      t = options[:tag] || self.class.default_tag
      tc = options[:tag_class] || :UNIVERSAL
      @tag = Der::Tag.new(tag: t, tag_class: tc, constructed: true)
      @indefinite = !!options[:indefinite]
      @value = value
    end

    def tag
      @tag.tag
    end

    def tag_class
      @tag.tag_class.tag_class
    end

    def indefinite?; @indefinite; end

    def constructed?; true; end

    def value
      unless defined?(@value)
        @value = parse_value(@der_value)
        @der_value = nil # erase the cached encoding
      end
      @value
    end

    def encode_to(io)
      if @der_value
        encode_cached_to(io)
      else
        encode_tlv_to(io)
      end
    end

    class << self

      def from_der(der)
        obj = allocate
        obj.instance_eval do
          @tag = der.tag
          @length = der.length
          @indefinite = der.length.indefinite?
          @der_value = der.value
          @parsed = true
        end
        obj
      end

    end

    def add_eoc(values, io)
      last = values.last
      # just add if it was not present in the values
      needs_eoc = last.nil? ||
                  !(last.tag == END_OF_CONTENTS && last.tag_class == :UNIVERSAL)

      EndOfContents.new.encode_to(io) if needs_eoc
    end

    protected

    def parsed?; @parsed; end

    private

    def parse_value(bytes)
      parser = Parser.new
      objects = []
      io = StringIO.new(bytes)

      while object = parser.parse(io)
        objects << object
      end

      # do not include END_OF_CONTENT
      objects.pop if @indefinite

      objects
    end

    def encode_cached_to(io)
      @tag.encode_to(io)
      @length.encode_to(io)
      io << @der_value
    end

    def encode_tlv_to(io)
      @tag.encode_to(io)
      if @length
        @length.encode_to(io)
        encode_values_to(io)
      else
        compute_lv_to(io)
      end
    end

    def compute_lv_to(io)
      value_io = StringIO.new(String.new)
      encode_values_to(value_io)
      value = value_io.string
      @length = Der::Length.new(length: value.size, indefinite: @indefinite)
      @length.encode_to(io)
      io << value
    end

    def encode_values_to(io)
      sorted = sort_values(value)
      sorted.each { |v| v.encode_to(io) }
      add_eoc(sorted, io) if indefinite?
    end

  end
end

require_relative 'constructed/sequence'
require_relative 'constructed/set'

