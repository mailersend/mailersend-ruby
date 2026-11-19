# frozen_string_literal: true

module Mailersend
  # Scheduled messages endpoint from MailerSend API.
  class ScheduledMessages
    attr_accessor :client,
                  :domain_id,
                  :status,
                  :page,
                  :limit,
                  :message_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @domain_id = domain_id
      @status = status
      @page = page
      @limit = limit
      @message_id = message_id
    end

    def get_list(*)
      client.http.get("#{client.api_base_url}/message-schedules")
    end

    def get_single(message_id:)
      client.http.get("#{client.api_base_url}/message-schedules/#{message_id}")
    end

    def delete(message_id:)
      client.http.delete("#{client.api_base_url}/message-schedules/#{message_id}")
    end
  end
end
