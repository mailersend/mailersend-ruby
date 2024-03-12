# frozen_string_literal: true

module Mailersend
  # Tokens endpoint from MailerSend API.
  class Tokens
    attr_accessor :client,
                  :name,
                  :scopes,
                  :token_id,
                  :status

    def initialize(client = Mailersend::Client.new)
      @client = client
      @name = {}
      @scopes = []
      @token_id = {}
      @status = {}
    end

    def create(name:, scopes:, domain_id:)
      json = {
        'name' => name,
        'scopes' => scopes,
        'domain_id' => domain_id
      }
      client.http.post("#{MAILERSEND_API_URL}/token", json: json)
    end

    def update(token_id:, status:)
      status = {
        status: status
      }
      client.http.put("#{MAILERSEND_API_URL}/token/#{token_id}/settings", json: status)
    end

    def delete(token_id:)
      client.http.delete("#{MAILERSEND_API_URL}/token/#{token_id}")
    end
  end
end
