# frozen_string_literal: true

module Mailersend
  # Messages endpoint from MailerSend API.
  class Messages
    attr_accessor :client,
                  :page,
                  :limit,
                  :message_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @message_id = message_id
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/messages',
                                       query: URI.encode_www_form(hash)))
    end

    def single(message_id:)
      client.http.get("#{MAILERSEND_API_URL}/messages/#{message_id}")
    end
  end
end
