require File.dirname(__FILE__) + '/spec_helper'

describe SMSWay::Config do

  it 'should return config path' do
    expect(SMSWay::Config.config_file).to eq(File.join(Dir.pwd, 'config', 'sms_way.yml'))
  end

  it 'should return clients directory' do
    expect(SMSWay::Config.clients_path).to eq(File.join(Dir.pwd, 'lib', 'sms_way'))
  end

  it 'should return auth_options of active_client' do
    expect(SMSWay::Config).to receive(:active_client).and_return('Kannel')
    expect(SMSWay::Config.auth_options_of).to eq({'username' => 'kannel', 'password' => 'password'})
  end

  it 'should return auth_options of client' do
    expect(SMSWay::Config.auth_options_of('UseSMS')).to eq({'username' => 'test', 'password' => 'pwd'})
  end

  it 'should retrun base_options of active_client' do
    expect(SMSWay::Config).to receive(:active_client).and_return('Kannel')
    expect(SMSWay::Config.base_options_of).to eq({'charset' => 'UTF-8', 'coding' => 2, 'dlr-mask' => 31,
                                              'dlr-url' => 'http://localhost:3000/sms_calback?status=%d&modem=%i&date=%t&hash_id=hiasafsio4343243'})
  end

  it 'should return empty base_options if not configured' do
    expect(SMSWay::Config.base_options_of('UseSMS')).to eq({})
  end

  it 'should return base_options of client' do
    expect(SMSWay::Config.base_options_of('Kannel')).to eq({'charset' => 'UTF-8', 'coding' => 2, 'dlr-mask' => 31,
                                              'dlr-url' => 'http://localhost:3000/sms_calback?status=%d&modem=%i&date=%t&hash_id=hiasafsio4343243'})
  end

  context 'when use it with Rails' do
    let(:fake_rails) { double('Rails', env: 'production', root: '/my_rails_app/') }
    before(:each) do
      stub_const('Rails', fake_rails)
    end

    it 'return config file' do
      expect(SMSWay::Config.config_file).to eq(File.join('/my_rails_app', 'config', 'sms_way.yml'))
    end

    it 'return clients path' do
      expect(SMSWay::Config.clients_path).to eq(File.join('/my_rails_app', 'lib', 'sms_way'))
    end

    it 'return correct env' do
      expect(SMSWay::Config.env).to eq('production')
    end

  end
end