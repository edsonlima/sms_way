require File.dirname(__FILE__) + '/spec_helper'

describe SMSWay do

  before(:each) do
    ENV['SMSWAY_ENV'] = 'development'
    Dir.should_receive(:pwd).any_number_of_times.and_return(File.expand_path(File.join('spec', 'dummy')))
  end

  it 'should return config path' do
    SMSWay::Config.config_file.should == File.join(Dir.pwd, 'config', 'sms_way.yml')
  end

  it 'should return clients directory' do
    SMSWay::Config.clients_path.should == File.join(Dir.pwd, 'lib', 'sms_way')
  end

  it 'should return auth_opitons of active_client' do
    SMSWay::Config.should_receive(:source).any_number_of_times.and_return(File.join(Dir.pwd, 'config', 'sms_way.yml'))
    SMSWay::Config.should_receive(:namespace).any_number_of_times.and_return('development')

    SMSWay::Config.auth_options_of.should == {'username' => 'kannel', 'password' => 'password'}
  end
end