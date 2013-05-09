module SMSWay
  module Registry
    def self.included(client_api)
      SMSWay.add_client(client_api)
    end
  end
end