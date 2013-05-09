require File.dirname(__FILE__) + '/spec_helper'

describe SMSWay::Base do

  describe 'When inherit a new class' do
    require './spec/dummy/lib/sms_way/kannel'

    it 'should add this class to clients list' do
      SMSWay.clients.should include(Kannel)
    end

    it 'should raise NotImplementedError if try to send a sms directly' do
      proc {
        SMSWay::Base.new(username: 'test', password: 'pwd').send_sms('554699919199', 'Never sent text')
      }.should raise_error(NotImplementedError, 'Implement send_sms(to, text, api_options = {}) in your client.')
    end
  end

end
