# frozen_string_literal: true

module Mailersend
  # Account endpoint from MailerSend API
  class Account
    attr_accessor :client

    def initialize(client = Mailersend::Client.new)
      @client = client
    end

    def get_account(*)
      client.http.get("#{client.api_base_url}/account")
    end
  end
end
