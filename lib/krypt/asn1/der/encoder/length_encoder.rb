module Krypt::Asn1
  module Der::LengthEncoder

    module_function

    def encode(length)
      return Der::Length::INDEFINITE_LENGTH_MASK.chr if length.indefinite?

      len = length.length
      len < 128 ? len.chr : complex_length(len)
    end

    private; module_function

    def complex_length(len)
      # TODO raise error if bytes.size too large
      num_bytes = bytelen(len)
      buf = String.new

      while len > 0
        buf.prepend((len & 0xff).chr)
        len >>= 8
      end

      buf.prepend((num_bytes | Der::Length::INDEFINITE_LENGTH_MASK).chr)
    end

    def bytelen(value)
      return 1 if value == 0
      (Math.log2(value) / 8).floor + 1
    end

  end
end

