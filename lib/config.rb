##
# Monkeypath settingslogic
class Settingslogic
  ##
  # fixes rspec to_ary error according to https://github.com/binarylogic/settingslogic/commit/d623622f7d8b184aebe9fda6c7996c4a44af5ee9
  def method_missing(name, *args, &block)
    super if name === :to_ary # delegate to_ary to Hash
    key = name.to_s
    return missing_key("Missing setting '#{key}' in #@section") unless has_key? key
    value = fetch(key)
    create_accessor_for(key)
    value.is_a?(Hash) ? self.class.new(value, "'#{key}' section in #@section") : value
  end

end

module SMSWay

  class Config < Settingslogic

    def self.new_source(value) #:no-doc:
      @source = value
      reload!
    end

    def self.new_namespace(value) #:no-doc:
      @namespace = value
      reload!
    end


    def self.config_file
      File.join(Dir.pwd, 'config', 'sms_way.yml')
    end

    def self.clients_path
      File.join(Dir.pwd, 'lib', 'sms_way')
    end


    def self.env
      defined?(Rails) ? Rails.env : ENV['SMSWAY_ENV']
    end

    source self.config_file
    namespace self.env

    def self.auth_options_of(client = self.active_client)
      self[client]['auth_options']
    end
  end
end
