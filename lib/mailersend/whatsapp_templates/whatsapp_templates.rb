# frozen_string_literal: true

module Mailersend
  # WhatsApp Templates endpoint from MailerSend API.
  class WhatsAppTemplates
    attr_accessor :client,
                  :whatsapp_account_id,
                  :status,
                  :category,
                  :language,
                  :page,
                  :limit,
                  :whatsapp_template_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @whatsapp_account_id = whatsapp_account_id
      @status = status
      @category = category
      @language = language
      @page = page
      @limit = limit
      @whatsapp_template_id = whatsapp_template_id
    end

    def list(whatsapp_account_id: nil, status: nil, category: nil, language: nil, page: nil, limit: nil)
      hash = {
        'whatsapp_account_id' => whatsapp_account_id,
        'status' => status,
        'category' => category,
        'language' => language,
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/whatsapp/templates',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def get(whatsapp_template_id:)
      client.http.get("#{MAILERSEND_API_URL}/whatsapp/templates/#{whatsapp_template_id}")
    end
  end
end
