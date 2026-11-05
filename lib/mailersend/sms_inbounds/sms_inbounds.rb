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

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: "#{client.api_path}/sms-inbounds",
                                       query: URI.encode_www_form(hash)))
    end

    def get_sms_inbound_route(sms_inbound_id:)
      client.http.get("#{client.api_base_url}/sms-inbounds/#{sms_inbound_id}")
    end

    def add_sms_inbound_route
      client.http.post("#{client.api_base_url}/sms-inbounds", json: @settings)
    end

    def update_sms_inbound_route(sms_inbound_id:)
      client.http.put("#{client.api_base_url}/sms-inbounds/#{sms_inbound_id}", json: @settings)
    end

    def delete_sms_inbound_route(sms_inbound_id:)
      client.http.delete("#{client.api_base_url}/sms-inbounds/#{sms_inbound_id}")
    end
  end
end
