# frozen_string_literal: true

module Mailersend
  # WhatsApp Messages endpoint from MailerSend API.
  class WhatsAppMessages
    attr_accessor :client,
                  :page,
                  :limit,
                  :whatsapp_message_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @whatsapp_message_id = whatsapp_message_id
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/whatsapp/messages',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def get(whatsapp_message_id:)
      client.http.get("#{MAILERSEND_API_URL}/whatsapp/messages/#{whatsapp_message_id}")
    end
  end
end
