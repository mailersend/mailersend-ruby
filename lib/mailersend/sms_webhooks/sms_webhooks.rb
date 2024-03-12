# frozen_string_literal: true

module Mailersend
  # SMS Webhook endpoint from MailerSend API.
  class SMSWebhooks
    attr_accessor :client,
                  :page,
                  :limit,
                  :sms_webhook_id,
                  :settings

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @sms_webhook_id = sms_webhook_id
      @settings = []
    end

    def list(sms_number_id:)
      hash = {
        'sms_number_id' => sms_number_id
      }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/sms-webhooks',
                                       query: URI.encode_www_form(hash)))
    end

    def get_sms_webhook_route(sms_webhook_id:)
      client.http.get("#{MAILERSEND_API_URL}/sms-webhooks/#{sms_webhook_id}")
    end

    def add_sms_webhook_route
      client.http.post("#{MAILERSEND_API_URL}/sms-webhooks", json: @settings)
    end

    def update_sms_webhook_route(sms_webhook_id:)
      client.http.put("#{MAILERSEND_API_URL}/sms-webhooks/#{sms_webhook_id}", json: @settings)
    end

    def delete_sms_webhook_route(sms_webhook_id:)
      client.http.delete("#{MAILERSEND_API_URL}/sms-webhooks/#{sms_webhook_id}")
    end
  end
end
