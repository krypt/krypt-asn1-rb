# encoding: BINARY

module Krypt::Asn1
  class Constructed
    include IOEncodable

    def initialize(options)
      if options.respond_to?(:has_key)
        init_hash(options)
      else
        init_value(options)
      end
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

    def default_tag
      raise "No default tag for Constructed class"
    end

    class << self

      def from_der(der)
        obj = allocate
        obj.instance_eval do
          @tag = der.tag
          @length = der.length
          @indefinite = der.length.indefinite?
          @der_value = der.value
        end
        obj
      end

    end

    private

    def init_hash(options)
      t = options[:tag] || default_tag
      tc = options[:tag_class] || :UNIVERSAL
      @tag = Der::Tag.new(tag: t, tag_class: tc, constructed: true)
      @value = options[:value]
      @indefinite = !!options[:indefinite]
    end

    def init_value(value)
      @value = value
      @tag = Der::Tag.new(tag: default_tag, tag_class: :UNIVERSAL, constructed: true)
    end

    def parse_value(bytes)
      parser = Parser.new
      objects = []
      io = StringIO.new(bytes)

      while object = parser.parse(io)
        objects << object
      end

      if @indefinite
        # do not include END_OF_CONTENT
        objects.pop
      end

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
      value = StringIO.new(String.new).tap do |io|
        encode_values_to(io)
      end.string
      @length = Der::Length.new(length: value.size, indefinite: @indefinite)
      @length.encode_to(io)
      io << value
    end

    def encode_values_to(io)
      @value.each { |v| v.encode_to(io) } 
      add_eoc(io) if @indefinite
    end

    def add_eoc(io)
      last = @value.last
      # just add if it was not present in the values
      unless last.tag == Der::Tag::END_OF_CONTENTS && last.tag_class == :UNIVERSAL
        EndOfContents.new.encode_to(io)
      end
    end

  end
end

require_relative 'constructed/sequence'
require_relative 'constructed/set'

