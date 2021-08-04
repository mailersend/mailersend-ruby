# frozen_string_literal: true

module Mailersend
  # Recipients endpoint from MailerSend API.
  class Recipients
    attr_accessor :client,
                  :page,
                  :limit,
                  :recipient_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @recipient_id = recipient_id
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      response = client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/recipients',
                                                  query: URI.encode_www_form(hash)))
      puts response
    end

    def single(recipient_id:)
      response = client.http.get("#{API_URL}/recipients/#{recipient_id}")
      puts response
    end

    def delete(recipient_id:)
      response = client.http.delete("#{API_URL}/recipients/#{recipient_id}")
      puts response
    end
  end
end
