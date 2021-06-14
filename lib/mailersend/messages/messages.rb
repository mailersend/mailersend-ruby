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
        "page" => page,
        "limit" => limit
      }

      response = client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/messages",
                                                  query: URI.encode_www_form(hash)))
      puts response
    end

    def single(message_id:)
      response = client.http.get("#{API_URL}/messages/#{message_id}")
      puts response
    end
  end
end
