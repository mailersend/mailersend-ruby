# frozen_string_literal: true

module Mailersend
  # SMS Inbound endpoint from MailerSend API.
  class SMSInbounds
    attr_accessor :client,
                  :page,
                  :limit,
                  :sms_number_id,
                  :sms_inbound_id,
                  :settings

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @sms_number_id = sms_number_id
      @sms_inbound_id = sms_inbound_id
      @settings = []
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/sms-inbounds',
                                       query: URI.encode_www_form(hash)))
    end

    def get_sms_inbound_route(sms_inbound_id:)
      client.http.get("#{API_URL}/sms-inbounds/#{sms_inbound_id}")
    end

    def add_sms_inbound_route
      client.http.post("#{API_URL}/sms-inbounds", json: @settings)
    end

    def update_sms_inbound_route(sms_inbound_id:)
      client.http.put("#{API_URL}/sms-inbounds/#{sms_inbound_id}", json: @settings)
    end

    def delete_sms_inbound_route(sms_inbound_id:)
      client.http.delete("#{API_URL}/sms-inbounds/#{sms_inbound_id}")
    end
  end
end
