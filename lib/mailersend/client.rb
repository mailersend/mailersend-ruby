# frozen_string_literal: true

require 'http'

# Deprecated: always points at v1. Use Mailersend::Client#api_base_url.
MAILERSEND_API_URL = 'https://api.mailersend.com/v1'
MAILERSEND_API_BASE_HOST = 'api.mailersend.com'

# mailersend-ruby is a gem that integrates all endpoints from MailerSend API
module Mailersend
  DEFAULT_API_VERSION = '2026-10'

  attr_reader :api_token

  # Inits the client.
  class Client
    attr_reader :api_version

    def initialize(api_token = ENV.fetch('MAILERSEND_API_TOKEN', nil), api_version: DEFAULT_API_VERSION)
      raise ArgumentError, 'API token is not provided' if api_token.nil?
      raise ArgumentError, "Invalid API version #{api_version.inspect}: use 'v1' or a dated version like '2026-10'" unless api_version.to_s.match?(/\A(v1|\d{4}-(0[1-9]|1[0-2]))\z/)

      @api_token = api_token
      @api_version = api_version.to_s
    end

    def api_path
      "/#{@api_version}"
    end

    def api_base_url
      "https://#{MAILERSEND_API_BASE_HOST}#{api_path}"
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
