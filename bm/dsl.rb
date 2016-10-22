require 'benchmark'
require 'krypt/asn1'
require 'openssl'

class A
  include Krypt::ASN1::DSL::Sequence

  asn1_integer :version, optional: true, default: 3
  asn1_ia5_string :text
  asn1_boolean :flag
  asn1_integer :size
end

data = Krypt::ASN1::Sequence.new([
  Krypt::ASN1::Ia5String.new("test"),
  Krypt::ASN1::Boolean.new(true),
  Krypt::ASN1::Integer.new(42)
]).to_der

n = 40_000

Benchmark.bm do |bm|

  bm.report("OpenSSL::ASN1::decode") do
    n.times do
      OpenSSL::ASN1.decode(data)
    end
  end

  bm.report("Krypt::ASN1::decode") do
    n.times do
      Krypt::ASN1.decode(data)
    end
  end

  bm.report("DSL::decode") do
    n.times do
      A.parse(data)
    end
  end

end

