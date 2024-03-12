# frozen_string_literal: true

module Mailersend
  # Inbound routing endpoint from MailerSend API.
  class InboundRouting
    attr_accessor :client,
                  :domain_id,
                  :page,
                  :limit,
                  :inbound_id,
                  :settings

    def initialize(client = Mailersend::Client.new)
      @client = client
      @domain_id = domain_id
      @page = page
      @limit = limit
      @inbound_id = inbound_id
      @settings = []
    end

    def get_inbound_routes(*)
      client.http.get("#{MAILERSEND_API_URL}/inbound")
    end

    def get_single_route(inbound_id:)
      client.http.get("#{MAILERSEND_API_URL}/inbound/#{inbound_id}")
    end

    def add_inbound_route
      client.http.post("#{MAILERSEND_API_URL}/inbound", json: @settings)
    end

    def update_inbound_route(inbound_id:)
      client.http.put("#{MAILERSEND_API_URL}/inbound/#{inbound_id}", json: @settings)
    end

    def delete_route(inbound_id:)
      client.http.delete("#{MAILERSEND_API_URL}/inbound/#{inbound_id}")
    end
  end
end
