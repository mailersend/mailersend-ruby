# frozen_string_literal: true

require 'base64'

module Mailersend
  # Send an email through MailerSend API
  class BulkEmail
    attr_accessor :client,
                  :messages

    def initialize(client = Mailersend::Client.new)
      @client = client
      @messages = []
    end

    def add_attachment(content:, filename:)
      data = File.read(content.to_s)
      encoded = Base64.strict_encode64(data)
      @attachments << {
        'content' => encoded,
        'filename' => filename
      }
    end

    def send
      response = client.http.post("#{API_URL}/bulk-email", json: @messages)
      puts response
      puts response.status.code
    end

    def get_bulk_status(bulk_email_id:)
      response = client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/bulk-email/#{bulk_email_id}"))
      puts response
    end
  end
end
