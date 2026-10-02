# frozen_string_literal: true

module Mailersend
  # WhatsApp Inbound Messages endpoint from MailerSend API.
  class WhatsAppInboundMessages
    attr_accessor :client,
                  :whatsapp_account_id,
                  :type,
                  :date_from,
                  :date_to,
                  :page,
                  :limit,
                  :whatsapp_inbound_message_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @whatsapp_account_id = whatsapp_account_id
      @type = type
      @date_from = date_from
      @date_to = date_to
      @page = page
      @limit = limit
      @whatsapp_inbound_message_id = whatsapp_inbound_message_id
    end

    def list(whatsapp_account_id: nil, type: nil, date_from: nil, date_to: nil, page: nil, limit: nil)
      hash = {
        'whatsapp_account_id' => whatsapp_account_id,
        'type[]' => type,
        'date_from' => date_from,
        'date_to' => date_to,
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/whatsapp/inbound-messages',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def get(whatsapp_inbound_message_id:)
      client.http.get("#{MAILERSEND_API_URL}/whatsapp/inbound-messages/#{whatsapp_inbound_message_id}")
    end
  end
end
