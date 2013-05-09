require 'api_smith'
require 'settingslogic'

require 'config'

module SMSWay

  class NoActiveClient < NameError; end

  def self.clients
    @clients ||= []
    @clients
  end

  def self.add_client(client)
    @clients ||= []
    @clients << client
  end

  def self.send_sms(to, text, api_options = {})
    self.active_client.send_sms(to, text, api_options)
  end

  def self.active_client
    return @active_client unless @active_client.nil?
    raise(NoActiveClient.new('active_client was not specified')) if SMSWay::Config.active_client.empty?
    client = @clients.detect {|k| k.to_s.upcase == SMSWay::Config.active_client.upcase}
    client.nil? ? raise(NameError.new("#{SMSWay::Config.active_client} was not registered as a SMSWay client")) : @active_client = client.new(SMSWay::Config.auth_options_of)
    @active_client
  end

  def self.active_client=(client)
    @active_client  = client
  end

  def self.start!
    Dir.glob(File.join(SMSWay::Config.clients_path, '**', '*.rb')).each {|f| require_relative f}
  end
end

require 'sms_way/registry'
require 'sms_way/base'
