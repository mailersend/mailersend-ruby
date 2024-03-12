# frozen_string_literal: true

require 'http'

MAILERSEND_API_URL = 'https://api.mailersend.com/v1'
MAILERSEND_API_BASE_HOST = 'api.mailersend.com'

# mailersend-ruby is a gem that integrates all endpoints from MailerSend API
module Mailersend
  attr_reader :api_token

  # Inits the client.
  class Client
    def initialize(api_token = ENV.fetch('MAILERSEND_API_TOKEN', nil))
      raise ArgumentError, 'API token is not provided' if api_token.nil?

      @api_token = api_token
    end

    def http
      HTTP
        .timeout(connect: 15, read: 30)
        .auth("Bearer #{@api_token}")
        .headers('User-Agent' => "MailerSend-client-ruby/#{Mailersend::VERSION}",
                 'Accept' => 'application/json')
    end
  end
end
