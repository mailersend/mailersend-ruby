# frozen_string_literal: true

module Mailersend
  # Send an SMS through MailerSend API
  class SMS
    attr_accessor :client,
                  :from,
                  :to,
                  :text,
                  :personalization

    def initialize(client = Mailersend::Client.new)
      @client = client
      @from = {}
      @to = []
      @text = {}
      @personalization = []
    end

    def add_from(from)
      @from = from
    end

    def add_to(to)
      @to << to
    end

    def add_text(text)
      @text = text
    end

    def add_personalization(personalization)
      @personalization << personalization
    end

    def send
      message = {
        'from' => @from,
        'to' => @to,
        'text' => @text,
        'personalization' => @personalization
      }

      response = client.http.post("#{MAILERSEND_API_URL}/sms", json: message.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {} })
      puts response
    end
  end
end
