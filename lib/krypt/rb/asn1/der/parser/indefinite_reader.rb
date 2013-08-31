# encoding: BINARY

module Krypt::Rb::Asn1
  class Der::IndefiniteReader

    def initialize(header_parser)
      @parser = header_parser
      @state = :read_header
      @header_offset = 0
    end

    def read(len=nil, outbuf=nil)
      return nil if @state == :done

      buf = ""
      read_bytes(len, buf)

      if outbuf
        outbuf.replace(buf)
      else
        buf
      end
    end

    private

    def read_bytes(len, buf)
      total = 0
      to_read = len
      while total != len && @state != :done
        s = send(@state, to_read)
        if s 
          buf << s
          size = s.size
          total += size
          to_read -= size if to_read
        end
      end
    end

    def read_header(len)
      @current_header = @parser.next
      raise "Premature end of value detected" unless @current_header
      @state = :process_tag
      nil
    end

    def process_tag(len)
      read_header_bytes(@current_header.tag.encoding, len, :process_length)
    end

    def process_length(len)
      s = read_header_bytes(@current_header.length.encoding, len, :process_value)
      check_done
      s
    end

    def process_value(len)
      s = @current_header.value_io.read(len)
      if s.nil? && @state != :done
        @state = :read_header
      end
      s
    end

    def read_header_bytes(bytes, len, next_state)
      available = bytes.size - @header_offset
      
      if len && len < available
        n_header_bytes(bytes, len)
      else
        all_header_bytes(bytes, available, next_state)
      end
    end

    def n_header_bytes(bytes, n)
      ret = bytes.slice(@header_offset, n)
      @header_offset += n
      ret
    end

    def all_header_bytes(bytes, n, next_state)
      @state = next_state
      @header_offset = 0
      bytes.slice(0, n)
    end

    ##
    # If state is :process_value, this means that the tag bytes have already
    # been consumed. As an EOC contains no value, we are done
    def check_done
      tag = @current_header.tag
      if (tag.tag == 0x00 && 
          tag.tag_class.mask == 0x00 && 
          @state == :process_value)
        @state = :done
      end
    end

  end
end

