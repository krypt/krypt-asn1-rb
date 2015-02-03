# encoding: BINARY

module Krypt::Asn1
  class BitString < Primitive

    def self.default_tag
      BIT_STRING
    end

    class Value

      attr_reader :unused_bits, :value

      def initialize(value, unused_bits=0)
        @value = value
        @unused_bits = unused_bits
        unless (0..7).include?(@unused_bits)
          raise "Unused bits must be 0..7"
        end
      end

    end

    def initialize(value, options={})
      unused_bits = options[:unused_bits] || 0
      super(Value.new(value, unused_bits), options)
    end

    def unused_bits
      super_value.unused_bits
    end


    def value
      super.value
    end

    private

    def super_value
      Primitive.instance_method(:value).bind(self).call
    end

  end
end

