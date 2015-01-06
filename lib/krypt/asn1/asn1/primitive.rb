require_relative 'primitive/lazy_encodeable_primitive'
require_relative 'primitive/lazy_parseable_primitive'

module Krypt::Asn1
  class Primitive < Asn1Base

    def initialize(value, options={})
      tag = options[:tag] || self.class.default_tag
      tag_class = options[:tag_class] || Der::TagClass::UNIVERSAL
      @der = LazyEncodeablePrimitive.new(tag, tag_class, value, self)
    end

    def tag
      @der.tag
    end

    def length
      @der.length
    end

    def value
      @der.parsed_value
    end

    def encode_to(io)
      @der.encode_to(io)
    end

    class << self

      def from_der(der)
        obj = allocate
        obj.instance_eval { @der = LazyParseablePrimitive.new(der, obj) }
        obj
      end

    end

    protected

    def encode_value(value)
      value
    end

    def parse_value(value)
      value
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

