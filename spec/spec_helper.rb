$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'sms_way')
ENV['SMSWAY_ENV'] = 'development'
SMSWay::Config.new_source(File.join(Dir.pwd, 'spec', 'dummy', 'config', 'sms_way.yml'))
SMSWay::Config.new_namespace('development')

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end