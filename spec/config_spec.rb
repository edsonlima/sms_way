require File.dirname(__FILE__) + '/spec_helper'

describe SMSWay do

  it 'should return config path' do
    SMSWay::Config.config_file.should == File.join(Dir.pwd, 'config', 'sms_way.yml')
  end

  it 'should return clients directory' do
    SMSWay::Config.clients_path.should == File.join(Dir.pwd, 'lib', 'sms_way')
  end

  it 'should return auth_options of active_client' do
    SMSWay::Config.should_receive(:active_client).any_number_of_times.and_return('Kannel')
    SMSWay::Config.auth_options_of.should == {'username' => 'kannel', 'password' => 'password'}
  end
end