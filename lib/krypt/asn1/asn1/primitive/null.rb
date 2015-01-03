# encoding: BINARY

module Krypt::Asn1
  class Null < Primitive

    def self.default_tag
      NULL
    end

    def initialize
      super(nil, tag: NULL, tag_class: :UNIVERSAL)
    end

    def parse_value(bytes)
      raise "NULL must not contain a value: #{bytes}" if bytes
      nil
    end

    def encode_value(value)
      nil
    end

  end
end

