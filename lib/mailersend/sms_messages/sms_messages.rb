# frozen_string_literal: true

module Mailersend
  # SMS Messages endpoint from MailerSend API.
  class SMSMessages
    attr_accessor :client,
                  :page,
                  :limit,
                  :sms_message_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @sms_message_id = sms_message_id
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/sms-messages',
                                                  query: URI.encode_www_form(hash)))
    end

    def get(sms_message_id:)
      client.http.get_single_route("#{API_URL}/sms-messages/#{sms_message_id}")
    end
  end
end
