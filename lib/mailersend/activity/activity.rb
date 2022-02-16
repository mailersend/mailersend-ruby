# frozen_string_literal: true

module Mailersend
  # Activity endpoint from MailerSend API
  class Activity
    attr_accessor :client,
                  :domain_id,
                  :page,
                  :limit,
                  :date_from,
                  :date_to

    def initialize(client = Mailersend::Client.new)
      @client = client
      @domain_id = domain_id
      @page = page
      @limit = limit
      @date_from = date_from
      @date_to = date_to
    end

    def get(domain_id:, page: nil, limit: nil, date_from: nil, date_to: nil)
      hash = {
        page: page,
        limit: limit,
        date_from: date_from,
        date_to: date_to
      }

      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/activity/#{domain_id}",
                                       query: URI.encode_www_form(hash.compact)))
    end
  end
end
