# frozen_string_literal: true

module Mailersend
  # SMS Activity endpoint from MailerSend API.
  class SMSActivity
    attr_accessor :client,
                  :page,
                  :limit

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/sms-activity',
                                       query: URI.encode_www_form(hash)))
    end
  end
end
