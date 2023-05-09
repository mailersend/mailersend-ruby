# frozen_string_literal: true

module Mailersend
  # Email verification endpoint from MailerSend API.
  class EmailVerification
    attr_accessor :client,
                  :page,
                  :limit,
                  :email_verification_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @email_verification_id = email_verification_id
    end

    def verify_an_email(email: nil)
      hash = {
        'email' => email
      }
      client.http.post("#{API_URL}/email-verification/verify", json: hash.compact)
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }
      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/email-verification',
                                       query: URI.encode_www_form(hash)))
    end

    def get_single_list(email_verification_id:)
      client.http.get("#{API_URL}/email-verification/#{email_verification_id}")
    end

    def create_a_list(name: nil, emails: nil)
      hash = {
        'name' => name,
        'emails' => emails
      }
      client.http.post("#{API_URL}/email-verification", json: hash.compact)
    end

    def verify_a_list(email_verification_id:)
      client.http.get("#{API_URL}/email-verification/#{email_verification_id}/verify")
    end

    def get_list_results(email_verification_id:)
      client.http.get("#{API_URL}/email-verification/#{email_verification_id}/results")
    end
  end
end
