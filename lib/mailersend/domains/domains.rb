# frozen_string_literal: true

module Mailersend
  # Domains endpoint from MailerSend API
  class Domains
    attr_accessor :client,
                  :domain_id,
                  :page,
                  :limit,
                  :verified

    def initialize(client = Mailersend::Client.new)
      @client = client
      @domain_id = domain_id
      @page = page
      @limit = limit
      @verified = verified
    end

    def list(page: nil, limit: nil, verified: nil)
      hash = {
        'page' => page,
        'limit' => limit,
        'verified' => verified
      }
      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/domains',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def single(domain_id:, page: nil, limit: nil, verified: nil)
      hash = {
        'page' => page,
        'limit' => limit,
        'verified' => verified
      }
      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/domains/#{domain_id}",
                                       query: URI.encode_www_form(hash.compact)))
    end

    def delete(domain_id:)
      client.http.delete(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/domains/#{domain_id}"))
    end

    def recipients(domain_id:)
      hash = {
        'page' => page,
        'limit' => limit
      }
      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/domains/#{domain_id}/recipients",
                                       query: URI.encode_www_form(hash.compact)))
    end

    def settings(domain_id:, send_paused: nil, track_clicks: nil, track_opens: nil, track_unsubscribe: nil, track_unsubscribe_html: nil, track_unsubscribe_plain: nil, track_content: nil, custom_tracking_enabled: nil, custom_tracking_subdomain: nil)
      hash = {
        'send_paused' => send_paused,
        'track_clicks' => track_clicks,
        'track_opens' => track_opens,
        'track_unsubscribe' => track_unsubscribe,
        'track_unsubscribe_html' => track_unsubscribe_html,
        'track_unsubscribe_plain' => track_unsubscribe_plain,
        'track_content' => track_content,
        'custom_tracking_enabled' => custom_tracking_enabled,
        'custom_tracking_subdomain' => custom_tracking_subdomain
      }
      client.http.put("#{API_URL}/domains/#{domain_id}/settings", json: hash.compact)
    end
  end
end
