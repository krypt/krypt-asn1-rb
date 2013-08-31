version = '0.0.1'

Gem::Specification.new do |s|

  s.name = 'krypt-asn1-rb'
  s.version = version

  s.author = 'Martin Bosslet'
  s.email = 'Martin.Bosslet@gmail.com'
  s.homepage = 'https://github.com/krypt/krypt-asn1-rb'
  s.summary = 'Platform- and library-independent cryptography for Ruby'
  s.description = 'krypt-asn1-rb seeks to provide an implementation of Krypt::ASN1 written entirely in Ruby' 

  s.required_ruby_version     = '>= 1.9.3'

  s.files = Dir.glob('{lib,spec}/**/*')
  s.files += ['LICENSE']
  s.extra_rdoc_files = [ "README.md" ]
  s.require_path = "lib"
  s.license = 'MIT'

end
