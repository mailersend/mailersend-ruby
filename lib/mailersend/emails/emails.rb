# frozen_string_literal: true

module Mailersend
  # Emails endpoint from MailerSend API.
  class Emails
    attr_accessor :client,
                  :domain_id,
                  :date_from,
                  :date_to,
                  :limit,
                  :page,
                  :email_id

    def initialize(client = Mailersend::Client.new)
      @client = client
    end

    def list(domain_id:, date_from:, date_to:, limit: nil, page: nil, status: nil, interaction: nil,
             recipient_email: nil, message_id: nil, template_id: nil, subject: nil, tag: nil)
      hash = {
        'domain_id' => domain_id,
        'date_from' => date_from,
        'date_to' => date_to,
        'limit' => limit,
        'page' => page,
        # The API rejects a scalar status/interaction with 422, so they are always sent in array form.
        'status[]' => status,
        'interaction[]' => interaction,
        'recipient_email' => recipient_email,
        'message_id' => message_id,
        'template_id' => template_id,
        'subject' => subject,
        'tag' => tag
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/emails',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def single(email_id:)
      client.http.get("#{MAILERSEND_API_URL}/email/#{email_id}")
    end
  end
end
