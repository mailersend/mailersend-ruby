# frozen_string_literal: true

module Mailersend
  # This is a class for getting the analytics from MailerSend API.
  class Analytics
    attr_accessor :client,
                  :date_from,
                  :date_to,
                  :events,
                  :domain_id,
                  :recipient_id,
                  :group_by,
                  :tags

    def initialize(client = Mailersend::Client.new)
      @client = client
      @date_from = ''
      @date_to = ''
      @events = []
      @domain_id = ''
      @recipient_id = ''
      @group_by = ''
      @tags = []
    end

    def date(date_from:, date_to:, events:, domain_id: nil, recipient_id: nil, group_by: nil, tags: nil)
      hash = {
        'date_from' => date_from,
        'date_to' => date_to,
        'event[]' => events,
        'domain_id' => domain_id,
        'recipient_id' => recipient_id,
        'group_by' => group_by,
        'tags[]' => tags
      }

      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/analytics/date',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def country(date_from:, date_to:, domain_id: nil, recipient_id: nil, tags: nil)
      hash = {
        domain_id: domain_id,
        recipient_id: recipient_id,
        date_from: date_from,
        date_to: date_to,
        'tags[]': tags
      }

      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/analytics/country',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def ua_name(date_from:, date_to:, domain_id: nil, recipient_id: nil, tags: nil)
      hash = {
        domain_id: domain_id,
        recipient_id: recipient_id,
        date_from: date_from,
        date_to: date_to,
        'tags[]': tags
      }

      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/analytics/ua-name',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def ua_type(date_from:, date_to:, domain_id: nil, recipient_id: nil, tags: nil)
      hash = {
        domain_id: domain_id,
        recipient_id: recipient_id,
        date_from: date_from,
        date_to: date_to,
        'tags[]': tags
      }

      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/analytics/ua-type',
                                       query: URI.encode_www_form(hash.compact)))
    end
  end
end
