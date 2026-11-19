# frozen_string_literal: true

module Mailersend
  # SMS Number endpoint from MailerSend API.
  class SMSNumber
    attr_accessor :client,
                  :paused,
                  :page,
                  :limit,
                  :sms_number_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @paused = paused
      @page = page
      @limit = limit
      @sms_number_id = sms_number_id
    end

    def list(page: nil, limit: nil)
      hash = {
        'page' => page,
        'limit' => limit
      }

      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: "#{client.api_path}/sms-numbers",
                                       query: URI.encode_www_form(hash)))
    end

    def get(sms_number_id:)
      client.http.get("#{client.api_base_url}/sms-numbers/#{sms_number_id}")
    end

    def update(sms_number_id:, paused: nil)
      hash = {
        'paused' => paused
      }
      client.http.put("#{client.api_base_url}/sms-numbers/#{sms_number_id}", json: hash.compact)
    end

    def delete(sms_number_id:)
      client.http.delete("#{client.api_base_url}/sms-numbers/#{sms_number_id}")
    end
  end
end
