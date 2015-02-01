module Krypt::Asn1
  module Encoder
    class LazyEncodableSet < LazyEncodableConstructed

      def encode_values_to(io, indefinite)
        sorted = sort_values(parsed_value)
        sorted.each { |v| v.encode_to(io) }
        add_eoc(sorted, io) if indefinite
      end

      private

      def sort_values(values)
        return values.sort if values.respond_to?(:sort)
        ary = []
        values.each { |v| ary << v }
        ary.sort
      end

    end
  end
end

