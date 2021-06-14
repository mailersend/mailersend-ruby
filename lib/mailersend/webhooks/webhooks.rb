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
        "domain_id" => domain_id
      }
      response = client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/webhooks",
                                                  query: URI.encode_www_form(hash)))
      puts response
    end

    def single(webhook_id:)
      response = client.http.get("#{API_URL}/webhooks/#{webhook_id}")
      puts response
    end

    def create(url:, name:, events:, domain_id:, enabled: nil)
      hash = {
        "url" => url,
        "name" => name,
        "events" => events,
        "domain_id" => domain_id,
        "enabled" => enabled.to_s == "true"
      }

      response = client.http.post("#{API_URL}/webhooks", json: hash.compact)
      puts response
    end

    def update(webhook_id:, url: nil, name: nil, events: nil, enabled: nil)
      hash = {
        "url" => url,
        "name" => name,
        "events" => events,
        "enabled" => enabled.to_s == "true"
      }
      response = client.http.put("#{API_URL}/webhooks/#{webhook_id}", json: hash.compact)
      puts response
    end

    def delete(webhook_id:)
      response = client.http.delete("#{API_URL}/webhooks/#{webhook_id}")
      puts response
    end
  end
end
