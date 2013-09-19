require_relative 'asn1/primitive'
require_relative 'asn1/constructed'
require_relative 'asn1/parser'

module Krypt::ASN1

  module_function

  def decode(io_or_string)
    Krypt::Asn1::Parser.new.parse(io_or_string)
  end

end
