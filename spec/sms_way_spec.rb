require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SMSWay do

  describe 'When start SMSWay' do
    before(:each) do
      ENV['SMSWAY_ENV'] = 'development'
      SMSWay::Config.should_receive(:clients_path).any_number_of_times.and_return(File.join(Dir.pwd, 'spec', 'dummy', 'lib', 'sms_way'))
      SMSWay::Config.should_receive(:source).any_number_of_times.and_return(File.join(Dir.pwd, 'spec', 'dummy', 'config', 'sms_way.yml'))
      SMSWay::Config.should_receive(:namespace).any_number_of_times.and_return('development')
      SMSWay.active_client = nil
      SMSWay.start!
    end

    it 'should detect active_client' do
      SMSWay.active_client.should be_instance_of(Kannel)
    end

    it 'should detect active_client when it is not a "regular" name'  do
      SMSWay::Config['active_client'] = 'UseSMS'
      SMSWay.active_client.should  be_instance_of(UseSMS)
    end

    it 'should load any clients in lib/sms_way directory' do
      SMSWay.clients.should have(2).items
      SMSWay.clients.should include(Kannel, UseSMS)
    end

    it 'should raise NameError if active_client is unregistred' do
      SMSWay::Config['active_client'] = 'UnregisteredClient'
      proc {
        SMSWay.active_client
      }.should raise_exception(NameError, 'UnregisteredClient was not registered as a SMSWay client')
    end

    it 'should raise NoActiveClient if active_client is empty' do
      SMSWay::Config['active_client'] = ''
      proc {
        SMSWay.active_client
      }.should raise_exception(SMSWay::NoActiveClient, 'active_client was not specified')
    end

    it 'should configure a new active_client' do
      c = UseSMS.new(user: 'user', password: 'pwd')
      SMSWay.active_client = c
      SMSWay.active_client.should equal(c)
    end

  end

  describe 'When try to send a sms' do

    before(:each) do
      ENV['SMSWAY_ENV'] = 'development'
      SMSWay::Config.should_receive(:clients_path).any_number_of_times.and_return(File.join(Dir.pwd, 'spec', 'dummy', 'lib', 'sms_way'))
      SMSWay::Config.should_receive(:source).any_number_of_times.and_return(File.join(Dir.pwd, 'spec', 'dummy', 'config', 'sms_way.yml'))
      SMSWay::Config.should_receive(:namespace).any_number_of_times.and_return('development')
      SMSWay::Config['active_client'] = 'Kannel'
      SMSWay.start!
    end

    it 'should raise a NoActiveClient if active_client was not especified' do
      SMSWay::Config['active_client'] = ''
      SMSWay.active_client = nil
      proc {
        SMSWay.send_sms('5546991999999', 'Never sent text')
      }.should raise_error(SMSWay::NoActiveClient, 'active_client was not specified')
    end

    it 'should send messages with active_client' do
      Kannel.any_instance.should_receive(:send_sms).with(any_args()).and_return('OK!')
      SMSWay.send_sms('554699190000', 'First message sent!').should == 'OK!'
    end

  end

end
