require_relative 'parser/header_parser'
require_relative 'parser/tag_parser'
require_relative 'parser/length_parser'
require_relative 'parser/definite_value_parser'
require_relative 'parser/indefinite_value_parser'

module Krypt::Asn1
  class Der::Parser

    attr_reader :io

    def initialize(io_or_string)
      if io_or_string.respond_to?(:read)
        @io = io_or_string
      else
        init_string(io_or_string)
      end
    end

    def next_header
      Der::HeaderParser.next_header(@io, self)
    end

    def value_parser(header)
      Der::HeaderParser.value_parser(@io, header)
    end

    private

    def init_string(s)
      s = s.to_s.force_encoding(Encoding::BINARY)
      @io = StringIO.new(s)
    end

  end
end
