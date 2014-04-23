require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SMSWay do

  describe 'When start SMSWay' do
    before(:each) do
      ENV['SMSWAY_ENV'] = 'development'
      expect(SMSWay::Config).to receive(:clients_path).and_return(File.join(File.expand_path(File.dirname(__FILE__)), 'spec', 'dummy', 'lib', 'sms_way'))
      SMSWay.active_client = nil
      SMSWay.start!
    end

    it 'should detect active_client' do
      SMSWay::Config['active_client'] = 'Kannel'
      expect(SMSWay.active_client).to be_instance_of(Kannel)
    end

    it 'should detect active_client when it is not a "regular" name'  do
      SMSWay::Config['active_client'] = 'UseSMS'
      expect(SMSWay.active_client).to be_instance_of(UseSMS)
    end

    it 'should load any clients in lib/sms_way directory' do
      expect(SMSWay.clients).to have(2).items
      expect(SMSWay.clients).to include(Kannel, UseSMS)
    end

    it 'should raise NameError if active_client is unregistred' do
      SMSWay::Config['active_client'] = 'UnregisteredClient'
      expect {SMSWay.active_client }.to raise_exception(NameError, 'UnregisteredClient was not registered as a SMSWay client')
    end

    it 'should raise NoActiveClient if active_client is empty' do
      SMSWay::Config['active_client'] = ''
      expect { SMSWay.active_client }.to raise_exception(SMSWay::NoActiveClient, 'active_client was not specified')
    end

    it 'should configure a new active_client' do
      c = UseSMS.new(user: 'user', password: 'pwd')
      SMSWay.active_client = c
      expect(SMSWay.active_client).to equal(c)
    end

  end

  describe 'When try to send a sms' do

    before(:each) do
      ENV['SMSWAY_ENV'] = 'development'
      SMSWay::Config.should_receive(:clients_path).and_return(File.join(File.expand_path(File.dirname(__FILE__)), 'spec', 'dummy', 'lib', 'sms_way'))
      SMSWay::Config['active_client'] = 'Kannel'
      SMSWay.start!
    end

    it 'should raise a NoActiveClient if active_client was not especified' do
      SMSWay::Config['active_client'] = ''
      SMSWay.active_client = nil
      expect { SMSWay.send_sms('5546991999999', 'Never sent text') }.to raise_error(SMSWay::NoActiveClient, 'active_client was not specified')
    end

    it 'should send messages with active_client' do
      expect_any_instance_of(Kannel).to receive(:send_sms).with(any_args()).and_return('OK!')
      expect(SMSWay.send_sms('554699190000', 'First message sent!')).to eq('OK!')
    end

  end

end
