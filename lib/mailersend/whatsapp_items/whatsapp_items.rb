# frozen_string_literal: true

module Mailersend
  # WhatsApp Items endpoint from MailerSend API.
  class WhatsAppItems
    attr_accessor :client,
                  :recipient,
                  :whatsapp_message_id,
                  :status,
                  :whatsapp_account_id,
                  :from,
                  :template_id,
                  :date_from,
                  :date_to,
                  :page,
                  :limit,
                  :whatsapp_item_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @recipient = recipient
      @whatsapp_message_id = whatsapp_message_id
      @status = status
      @whatsapp_account_id = whatsapp_account_id
      @from = from
      @template_id = template_id
      @date_from = date_from
      @date_to = date_to
      @page = page
      @limit = limit
      @whatsapp_item_id = whatsapp_item_id
    end

    def list(recipient: nil, whatsapp_message_id: nil, status: nil, whatsapp_account_id: nil, from: nil,
             template_id: nil, date_from: nil, date_to: nil, page: nil, limit: nil)
      hash = {
        'recipient' => recipient,
        'whatsapp_message_id' => whatsapp_message_id,
        'status[]' => status,
        'whatsapp_account_id' => whatsapp_account_id,
        'from' => from,
        'template_id' => template_id,
        'date_from' => date_from,
        'date_to' => date_to,
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/whatsapp/items',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def get(whatsapp_item_id:)
      client.http.get("#{MAILERSEND_API_URL}/whatsapp/items/#{whatsapp_item_id}")
    end
  end
end
