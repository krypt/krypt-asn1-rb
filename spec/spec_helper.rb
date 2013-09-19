if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
elsif ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'krypt/asn1'
