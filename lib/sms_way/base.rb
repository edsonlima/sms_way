module SMSWay

  # Represents a client API
  #
  # All API classes must inherit from this class, and be saved in lib/deliverers directory.
  class Base
    include APISmith::Client

    def self.inherited(subclass)
      subclass.class_eval { include SMSWay::Registry }
    end

    def initialize(auth_options)
      add_query_options! auth_options
    end

    # <b>Implement this method in your client implementation.</b>
    #
    # Sends a SMS message to clients specified in +to+ param.
    #
    # ==== Required parameters
    # * +to+ - An array with destination addresses
    # * +text+ - The message text.
    #
    # ==== Optional parameters
    # * +api_options+ An hash with any optional or specific API parameters
    def send_sms(to, text, api_options = {})
      raise NotImplementedError.new('Implement send_sms(to, text, api_options = {}) in your client.')
    end
  end
end
