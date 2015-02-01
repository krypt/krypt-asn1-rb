module Krypt::Asn1
  class DisplayVisitor

    def initialize
      @buf = StringIO.new
      @level = 0
    end

    def pre_constructed(constructed)
      indent
      write_header(constructed)
      write("\n")
      @level += 2
    end

    def post_constructed(constructed)
      @level -= 2
      indent
      write(">\n")
    end

    def primitive(primitive)
      indent
      write_header(primitive)
      write(" value: #{primitive.value.to_s.inspect}>\n")
    end

    def to_s
      @buf.string
    end

    private

    def indent
      @buf << (" " * @level)
    end

    def write(token)
      @buf << token
    end

    def write_header(der)
     write("<#{der.class.name}[#{tag_class(der)} #{der.tag.tag} #{length(der)}]")
    end

    def tag_class(der)
      tc = case der.tag.tag_class
      when Der::TagClass::UNIVERSAL then :UNIVERSAL
      when Der::TagClass::APPLICATION then :APPLICATION
      when Der::TagClass::CONTEXT_SPECIFIC then :CONTEXT_SPECIFIC
      when Der::TagClass::PRIVATE then :PRIVATE
      end
    end

    def length(der)
      len = der.length
      len.indefinite? ? :indefinite : "length: #{len.length}"
    end

  end
end
