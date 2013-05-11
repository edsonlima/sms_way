require File.dirname(__FILE__) + '/spec_helper'

describe SMSWay::Config do

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

  it 'should return auth_options of client' do
    SMSWay::Config.auth_options_of('UseSMS').should == {'username' => 'test', 'password' => 'pwd'}
  end

  it 'should retrun base_options of active_client' do
    SMSWay::Config.should_receive(:active_client).any_number_of_times.and_return('Kannel')
    SMSWay::Config.base_options_of.should == {'charset' => 'UTF-8', 'coding' => 2, 'dlr-mask' => 31,
                                              'dlr-url' => 'http://localhost:3000/sms_calback?status=%d&modem=%i&date=%t&hash_id=hiasafsio4343243'}
  end


  it 'should return empty base_options if not configured' do
    SMSWay::Config.base_options_of('UseSMS').should == {}
  end

  it 'should return base_options of client' do
    SMSWay::Config.base_options_of('Kannel').should == {'charset' => 'UTF-8', 'coding' => 2, 'dlr-mask' => 31,
                                              'dlr-url' => 'http://localhost:3000/sms_calback?status=%d&modem=%i&date=%t&hash_id=hiasafsio4343243'}
  end
end