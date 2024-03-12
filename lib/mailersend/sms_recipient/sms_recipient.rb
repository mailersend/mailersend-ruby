# frozen_string_literal: true

module Mailersend
  # SMS Recipient endpoint from MailerSend API.
  class SMSRecipient
    attr_accessor :client,
                  :status,
                  :sms_number_id,
                  :sms_recipient_id,
                  :page,
                  :limit

    def initialize(client = Mailersend::Client.new)
      @client = client
      @status = status
      @sms_number_id = sms_number_id
      @sms_recipient_id = sms_recipient_id
      @page = page
      @limit = limit
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/sms-recipients',
                                       query: URI.encode_www_form(hash)))
    end

    def get(sms_recipient_id:)
      client.http.get("#{MAILERSEND_API_URL}/sms-recipients/#{sms_recipient_id}")
    end

    def update(sms_recipient_id:, status: nil)
      hash = {
        'status' => status
      }
      client.http.put("#{MAILERSEND_API_URL}/sms-recipients/#{sms_recipient_id}", json: hash.compact)
    end
  end
end
