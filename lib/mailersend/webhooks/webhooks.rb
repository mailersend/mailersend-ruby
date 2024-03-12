# frozen_string_literal: true

module Mailersend
  # This is a class for getting the analytics from MailerSend API.
  class Webhooks
    attr_accessor :client,
                  :domain_id,
                  :url,
                  :name,
                  :events,
                  :enabled

    def initialize(client = Mailersend::Client.new)
      @client = client
      @domain_id = domain_id
      @url = url
      @name = name
      @events = []
      @enabled = enabled
      @events = events
    end

    def list(domain_id:)
      hash = {
        'domain_id' => domain_id
      }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: '/v1/webhooks',
                                       query: URI.encode_www_form(hash)))
    end

    def single(webhook_id:)
      client.http.get("#{MAILERSEND_API_URL}/webhooks/#{webhook_id}")
    end

    def create(url:, name:, events:, domain_id:, enabled: nil)
      hash = {
        'url' => url,
        'name' => name,
        'events' => events,
        'domain_id' => domain_id,
        'enabled' => enabled.to_s == 'true'
      }

      client.http.post("#{MAILERSEND_API_URL}/webhooks", json: hash.compact)
    end

    def update(webhook_id:, url: nil, name: nil, events: nil, enabled: nil)
      hash = {
        'url' => url,
        'name' => name,
        'events' => events,
        'enabled' => enabled.to_s == 'true'
      }
      client.http.put("#{MAILERSEND_API_URL}/webhooks/#{webhook_id}", json: hash.compact)
    end

    def delete(webhook_id:)
      client.http.delete("#{MAILERSEND_API_URL}/webhooks/#{webhook_id}")
    end
  end
end
