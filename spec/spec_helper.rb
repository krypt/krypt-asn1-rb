if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
elsif ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

require 'krypt/asn1'
