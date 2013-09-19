# encoding: BINARY

module Krypt::Rb::Asn1
  class Constructed < Asn1

    def initialize(options)
      super(options)
      @constructed = true
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

    def encode_value(values)
      StringIO.new(String.new).tap do |io|
        values.each { |v| v.encode_to(io) }
        if @indefinite
          add_eoc(values, io)
        end
      end.string
    end

    private

    def add_eoc(values, io)
      last = values.last
      # just add if it was not present in the values
      unless last.tag == Der::Tag::END_OF_CONTENTS && last.tag_class == :UNIVERSAL
        EndOfContents.new.encode_to(io)
      end
    end

  end
end

require_relative 'constructed/sequence'
require_relative 'constructed/set'

