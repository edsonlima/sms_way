require File.dirname(__FILE__) + '/spec_helper'

describe 'When include registry module in a class' do
  require './spec/dummy/test_registry'

  it 'should include this class in client list' do
    SMSWay.clients.should include(TestRegistry)
  end

  it 'should not include another classes' do
    SMSWay.clients.should_not include(Unregistred)
  end

  after(:all) do
    SMSWay.clients.delete(TestRegistry)
  end

end