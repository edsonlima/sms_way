require File.dirname(__FILE__) + '/spec_helper'

describe SMSWay do

  describe 'When inherit a new class' do
    require './spec/dummy/lib/sms_way/kannel'

    it 'should add this class to clients list' do
      SMSWay.clients.should include(Kannel)
    end

  end

  describe 'Using to send messages' do
    require './spec/dummy/lib/sms_way/use_sms'

    it 'should raise NotImplementedError if try to send a sms directly' do
      proc {
        SMSWay::Base.new(username: 'test', password: 'pwd').send_sms('554699919199', 'Never sent text')
      }.should raise_error(NotImplementedError, 'Implement send_sms(to, text, api_options = {}) in your client.')
    end

    it 'should add extra_options configurations when create a new instance if exist in config file' do
      SMSWay::Config['active_client'] = 'Kannel'
      k = Kannel.new(user: 'name', password: 'pwd')
      k.extra_options.should have_key('charset')
      k.extra_options.should have_key('dlr-url')
    end

    it 'should create normaly without extra_options config in config file' do
      SMSWay::Config['active_client'] = 'UseSMS'
      UseSMS.new(user: 'name', passowrd: 'pwd').extra_options.should be_nil
    end

  end

end
