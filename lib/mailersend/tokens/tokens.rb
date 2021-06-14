# frozen_string_literal: true

module Mailersend
  # Tokens endpoint from MailerSend API.
  class Tokens
    attr_accessor :client,
                  :token_name,
                  :token_scopes,
                  :token_id,
                  :status

    def initialize(client = Mailersend::Client.new)
      @client = client
      @token_name = {}
      @token_scopes = []
      @token_id = {}
      @status = {}
    end

    def create(token_name:, token_scopes:)
      json = {
        "name" => token_name,
        "scopes" => token_scopes
      }
      response = client.http.post("#{API_URL}/token", json: json)
      puts response
    end

    def update(token_id:, status:)
      status = {
        "status": status
      }
      response = client.http.put("#{API_URL}/token/#{token_id}/settings", json: status)
      puts response
    end

    def delete(token_name:)
      response = client.http.delete("#{API_URL}/token/#{token_name}")
      puts response
    end
  end
end
