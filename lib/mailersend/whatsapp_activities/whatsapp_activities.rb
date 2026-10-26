# frozen_string_literal: true

module Mailersend
  # WhatsApp Activities endpoint from MailerSend API.
  class WhatsAppActivities
    attr_accessor :client,
                  :whatsapp_item_id,
                  :whatsapp_message_id,
                  :recipient,
                  :type,
                  :date_from,
                  :date_to,
                  :page,
                  :limit

    def initialize(client = Mailersend::Client.new)
      @client = client
      @whatsapp_item_id = whatsapp_item_id
      @whatsapp_message_id = whatsapp_message_id
      @recipient = recipient
      @type = type
      @date_from = date_from
      @date_to = date_to
      @page = page
      @limit = limit
    end

    def list(whatsapp_item_id: nil, whatsapp_message_id: nil, recipient: nil, type: nil, date_from: nil, date_to: nil,
             page: nil, limit: nil)
      hash = {
        'whatsapp_item_id' => whatsapp_item_id,
        'whatsapp_message_id' => whatsapp_message_id,
        'recipient' => recipient,
        'type[]' => type,
        'date_from' => date_from,
        'date_to' => date_to,
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/whatsapp/activities',
                                       query: URI.encode_www_form(hash.compact)))
    end
  end
end
