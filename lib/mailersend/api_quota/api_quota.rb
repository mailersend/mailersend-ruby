# frozen_string_literal: true

module Mailersend
  # API Quota endpoint from MailerSend API
  class APIQuota
    attr_accessor :client

    def initialize(client = Mailersend::Client.new)
      @client = client
    end

    def get_api_quota(*)
      client.http.get("#{MAILERSEND_API_URL}/api-quota")
    end
  end
end
