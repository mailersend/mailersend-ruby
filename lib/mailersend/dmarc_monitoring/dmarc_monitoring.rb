# frozen_string_literal: true

module Mailersend
  # DMARC Monitoring endpoint from MailerSend API.
  class DmarcMonitoring
    attr_accessor :client, :monitor_id, :ip, :page, :limit

    def initialize(client = Mailersend::Client.new)
      @client = client
    end

    def list(page: nil, limit: nil)
      hash = { 'page' => page, 'limit' => limit }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST,
                                       path: '/v1/dmarc-monitoring',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def create(domain_id:)
      client.http.post("#{MAILERSEND_API_URL}/dmarc-monitoring",
                       json: { 'domain_id' => domain_id })
    end

    def update(monitor_id:, wanted_dmarc_record:)
      client.http.put("#{MAILERSEND_API_URL}/dmarc-monitoring/#{monitor_id}",
                      json: { 'wanted_dmarc_record' => wanted_dmarc_record })
    end

    def delete(monitor_id:)
      client.http.delete("#{MAILERSEND_API_URL}/dmarc-monitoring/#{monitor_id}")
    end

    def report(monitor_id:, page: nil, limit: nil)
      hash = { 'page' => page, 'limit' => limit }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST,
                                       path: "/v1/dmarc-monitoring/#{monitor_id}/report",
                                       query: URI.encode_www_form(hash.compact)))
    end

    def report_by_ip(monitor_id:, ip:, page: nil, limit: nil)
      hash = { 'page' => page, 'limit' => limit }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST,
                                       path: "/v1/dmarc-monitoring/#{monitor_id}/report/#{ip}",
                                       query: URI.encode_www_form(hash.compact)))
    end

    def report_sources(monitor_id:)
      client.http.get("#{MAILERSEND_API_URL}/dmarc-monitoring/#{monitor_id}/report-sources")
    end

    def add_favorite(monitor_id:, ip:)
      client.http.put("#{MAILERSEND_API_URL}/dmarc-monitoring/#{monitor_id}/favorite/#{ip}")
    end

    def remove_favorite(monitor_id:, ip:)
      client.http.delete("#{MAILERSEND_API_URL}/dmarc-monitoring/#{monitor_id}/favorite/#{ip}")
    end
  end
end
