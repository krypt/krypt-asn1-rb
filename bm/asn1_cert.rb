require 'benchmark'
require 'krypt/asn1'
require 'openssl'

n = 20_000
cert = File.read('eff.cer')

Benchmark.bm do |bm|

  bm.report("OpenSSL::ASN1::decode") do
    n.times do
      OpenSSL::ASN1.decode(cert)
    end
  end

  bm.report("OpenSSL::X509::new") do
    n.times do
      OpenSSL::X509::Certificate.new(cert)
    end
  end

  bm.report("Krypt::ASN1::decode") do
    n.times do
      Krypt::ASN1.decode(cert)
    end
  end

end

Benchmark.bm do |bm|

  bm.report("OpenSSL::ASN1::decode / to_der") do
    n.times do
      c = OpenSSL::ASN1.decode(cert)
      c.to_der
    end
  end

  bm.report("OpenSSL::X509::new / to_der") do
    n.times do
      c = OpenSSL::X509::Certificate.new(cert)
      c.to_der
    end
  end

  bm.report("Krypt::ASN1::decode / to_der") do
    n.times do
      c = Krypt::ASN1.decode(cert)
      c.to_der
    end
  end

end
