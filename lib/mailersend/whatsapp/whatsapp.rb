# frozen_string_literal: true

module Mailersend
  # Send a WhatsApp message through MailerSend API
  class WhatsApp
    attr_accessor :client,
                  :from,
                  :to,
                  :template_id,
                  :personalization

    def initialize(client = Mailersend::Client.new)
      @client = client
      @from = ''
      @to = []
      @template_id = ''
      @personalization = []
    end

    def add_from(from)
      @from = from
    end

    def add_to(to)
      @to << to
    end

    def add_template_id(template_id)
      @template_id = template_id
    end

    def add_personalization(personalization)
      @personalization << personalization
    end

    def send
      message = {
        'from' => @from,
        'to' => @to,
        'template_id' => @template_id,
        'personalization' => @personalization
      }

      response = client.http.post("#{MAILERSEND_API_URL}/whatsapp/send", json: message.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {} })
      puts response
    end
  end
end