# frozen_string_literal: true

module Mailersend
  # WhatsApp Recipient endpoint from MailerSend API.
  class WhatsAppRecipient
    attr_accessor :client,
                  :status,
                  :phone_number,
                  :page,
                  :limit,
                  :whatsapp_recipient_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @status = status
      @phone_number = phone_number
      @page = page
      @limit = limit
      @whatsapp_recipient_id = whatsapp_recipient_id
    end

    def list(status: nil, phone_number: nil, page: nil, limit: nil)
      hash = {
        'status' => status,
        'phone_number' => phone_number,
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/whatsapp/recipients',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def get(whatsapp_recipient_id:)
      client.http.get("#{MAILERSEND_API_URL}/whatsapp/recipients/#{whatsapp_recipient_id}")
    end
  end
end
