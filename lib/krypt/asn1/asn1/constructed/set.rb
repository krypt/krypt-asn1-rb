module Krypt::Asn1
  class Set < Constructed

    def self.default_tag
      SET
    end

    def sort_values(values)
      # preserve potentially wrong order for parsed SETs
      return values if parsed?
      return values.sort if values.respond_to?(:sort)
      ary = []
      values.each { |v| ary << v }
      ary.sort
    end

  end
end

