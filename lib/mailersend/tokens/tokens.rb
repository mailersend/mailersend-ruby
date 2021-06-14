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

    def create(name:, scopes:)
      json = {
        "name" => name,
        "scopes" => scopes
      }
      response = client.http.post("#{API_URL}/token", json: json)
      puts response
    end

    def update(token_id:, status:)
      status = {
        status: status
      }
      response = client.http.put("#{API_URL}/token/#{token_id}/settings", json: status)
      puts response
    end

    def delete(token_id:)
      response = client.http.delete("#{API_URL}/token/#{token_id}")
      puts response
    end
  end
end
