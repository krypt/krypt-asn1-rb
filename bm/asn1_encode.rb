require 'benchmark'
require 'time'
require 'krypt/asn1'
require 'openssl'

require 'stackprof'

def ossl_content
  [
    OpenSSL::ASN1::Boolean.new(true),
    OpenSSL::ASN1::Integer.new(65536),
    OpenSSL::ASN1::Integer.new(1234567890123456789012345678901234567890),
    OpenSSL::ASN1::BitString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::OctetString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::Null.new(nil),
    OpenSSL::ASN1::ObjectId.new("1.30.87654321.987654321.23"),
    OpenSSL::ASN1::Enumerated.new(65536),
    OpenSSL::ASN1::Enumerated.new(1234567890123456789012345678901234567890),
    OpenSSL::ASN1::UTF8String.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::UTCTime.new(Time.now),
    OpenSSL::ASN1::UTCTime.new(Time.now.to_i),
    OpenSSL::ASN1::GeneralizedTime.new(Time.now),
    OpenSSL::ASN1::GeneralizedTime.new(Time.now.to_i),
    OpenSSL::ASN1::NumericString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::PrintableString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::T61String.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::VideotexString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::IA5String.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::GraphicString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::ISO64String.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::GeneralString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::UniversalString.new("abcdefghijklmnopqrstuvwxyz"),
    OpenSSL::ASN1::BMPString.new("abcdefghijklmnopqrstuvwxyz")
  ]
end

def krypt_content
  [
    Krypt::Asn1::Boolean.new(true),
    Krypt::Asn1::Integer.new(65536),
    Krypt::Asn1::Integer.new(1234567890123456789012345678901234567890),
    Krypt::Asn1::BitString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::OctetString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::Null.new,
    Krypt::Asn1::ObjectId.new([1, 30, 87654321, 987654321 ,23]),
    Krypt::Asn1::Enumerated.new(65536),
    Krypt::Asn1::Enumerated.new(1234567890123456789012345678901234567890),
    Krypt::Asn1::Utf8String.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::UtcTime.new(Time.now),
    Krypt::Asn1::UtcTime.new(DateTime.now),
    Krypt::Asn1::GeneralizedTime.new(Time.now),
    Krypt::Asn1::GeneralizedTime.new(DateTime.now),
    Krypt::Asn1::NumericString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::PrintableString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::T61String.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::VideotexString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::Ia5String.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::GraphicString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::Iso64String.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::GeneralString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::UniversalString.new("abcdefghijklmnopqrstuvwxyz"),
    Krypt::Asn1::BmpString.new("abcdefghijklmnopqrstuvwxyz")
  ]
end

Benchmark.bm do |bm|
  filename = "bmtmp"
  file = File.open(filename, "wb")
  n = 20_000

  krypt_asn1 = Krypt::Asn1::Sequence.new(krypt_content)
  ossl_asn1 = OpenSSL::ASN1::Sequence.new(ossl_content)

  bm.report("OpenSSL encode generated once(n=#{n}) ") { n.times { ossl_asn1.to_der } }
  bm.report("Krypt encode generated once(n=#{n}) ") { n.times { krypt_asn1.to_der } }
  bm.report("OpenSSL encode generated n times(n=#{n}) ") do
    n.times do
      OpenSSL::ASN1::Sequence.new(ossl_content).to_der
    end
  end
  bm.report("Krypt encode generated n times(n=#{n}) ") do
    StackProf.run(mode: :cpu, out: 'stackprof-encode.dump') do
      n.times do
        Krypt::Asn1::Sequence.new(krypt_content).to_der
      end
    end
  end
end

exit

Benchmark.bm do |bm|

  bm.report("Krypt encode generated n times SEQ(n=#{n}) ") do
    n.times do
      krypt_seq1 = Krypt::Asn1::Sequence.new(krypt_content)
      krypt_seq2 = Krypt::Asn1::Sequence.new(krypt_content)
      Krypt::Asn1::Sequence.new([krypt_seq1, krypt_seq2]).to_der
    end
  end
  bm.report("Krypt encode generated n times SET(n=#{n}) ") do
    n.times do
      krypt_set1 = Krypt::Asn1::Set.new(krypt_content)
      krypt_set2 = Krypt::Asn1::Set.new(krypt_content)
      Krypt::Asn1::Sequence.new([krypt_set1, krypt_set2]).to_der
    end
  end

  bm.report("OpenSSL encode generated once to file(n=#{n}) ") do
    n.times do
      content = ossl_asn1.to_der
      file.print(content)
      file.rewind
    end
  end
  bm.report("Krypt encode generated once to file(n=#{n}) ") { n.times { krypt_asn1.encode_to(file); file.rewind } }
  bm.report("OpenSSL encode generated n times to file(n=#{n}) ") do
    n.times do
      ossl_seq = OpenSSL::ASN1::Sequence.new(ossl_content)
      ossl_set = OpenSSL::ASN1::Set.new(ossl_content)
      content = OpenSSL::ASN1::Sequence.new([krypt_seq, krypt_set]).to_der
      file.print(content)
      file.rewind
    end
  end
  bm.report("Krypt encode generated n times to file(n=#{n}) ") do
    n.times do
      krypt_seq = Krypt::Asn1::Sequence.new(krypt_content)
      krypt_set = Krypt::Asn1::Set.new(krypt_content)
      Krypt::Asn1::Sequence.new([krypt_seq, krypt_set]).encode_to(file)
      file.rewind
    end
  end

  bm.report("OpenSSL encode generated once to StringIO(n=#{n}) ") do
    n.times do
      content = ossl_asn1.to_der
      StringIO.new << content
    end
  end
  bm.report("Krypt encode generated once to StringIO(n=#{n}) ") { n.times { krypt_asn1.encode_to(StringIO.new) } }
  bm.report("OpenSSL encode generated n times to StringIO(n=#{n}) ") do
    n.times do
      ossl_seq = OpenSSL::ASN1::Sequence.new(ossl_content)
      ossl_set = OpenSSL::ASN1::Set.new(ossl_content)
      content = OpenSSL::ASN1::Sequence.new([krypt_seq, krypt_set]).to_der
      StringIO.new << content
    end
  end
  bm.report("Krypt encode generated n times to StringIO(n=#{n}) ") do
    n.times do
      krypt_seq = Krypt::Asn1::Sequence.new(krypt_content)
      krypt_set = Krypt::Asn1::Set.new(krypt_content)
      Krypt::Asn1::Sequence.new([krypt_seq, krypt_set]).encode_to(StringIO.new)
    end
  end

  File.delete(filename)
end

