module Krypt::Asn1
  module Comparator

    module_function

    def compare(der1, der2)
      result = compare_tags(der1.tag, der2.tag)
      return result if result
      result = compare_encoding(der1.length.encoding, der2.length.encoding)
      return result if result
      result = compare_encoding(der1.der_value, der2.der_value)
      result ? result : 0
    end

    private; module_function

    def compare_tags(tag1, tag2)
      t1 = tag1.tag
      t2 = tag2.tag

      return 1 if eoc?(t1, tag1.tag_class)
      return -1 if eoc?(t2, tag2.tag_class)
      return -1 if t1 < t2
      return 1 if t1 > t2
    end

    def compare_encoding(e1, e2)
      l1 = e1.size
      l2 = e2.size
      min = l1 < l2 ? l1 : l2
      min.times do |i|
        b1 = e1.getbyte(i)
        b2 = e2.getbyte(i)
        return b1 < b2 ? -1 : 1 if b1 != b2
      end

      return -1 if l1 < l2
      return 1 if l1 > l2
    end

    def eoc?(t, tc)
      t == END_OF_CONTENTS && tc == Der::TagClass::UNIVERSAL
    end

  end
end
