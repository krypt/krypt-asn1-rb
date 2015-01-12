module Krypt
  module Asn1
    class Primitive < Asn1Base

      def initialize(value, options={})
        @der = Asn1::Encoder.new_encodable_primitive(self, value, options)
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

      def accept(visitor)
        visitor.visit_primitive(self)
      end

      class << self

        def from_der(der)
          obj = allocate
          obj.instance_eval { @der = Asn1::Parser.new_parsable_primitive(obj, der) }
          obj
        end

      end

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

