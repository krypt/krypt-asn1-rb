module Krypt::ASN1
  class Der::DefiniteValueParser

    def initialize(io, length)
      @io = io
      @available = length
    end

    def read(len=nil, outbuf=nil)
      return nil if @available == 0

      l = determine_len(len)
      s = read_bytes(l, outbuf)
      @available -= s.size
      s
    end

    private

    def read_bytes(l, outbuf)
      if outbuf
        @io.read(l, outbuf)
      else
        @io.read(l)
      end
    end

    def determine_len(len=nil)
      return @available unless len
      len <= @available ? len : @available
    end

  end
end

