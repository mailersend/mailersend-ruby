# frozen_string_literal: true

require 'base64'

module Mailersend
  # Send an email through MailerSend API
  class Email
    attr_accessor :client,
                  :from,
                  :recipients,
                  :subject,
                  :text,
                  :html,
                  :ccs,
                  :bcc,
                  :reply_to,
                  :attachments,
                  :template_id,
                  :tags,
                  :variables,
                  :personalization,
                  :send_at

    def initialize(client = Mailersend::Client.new)
      @client = client
      @from = {}
      @recipients = []
      @ccs = []
      @bcc = []
      @reply_to = {}
      @subject = nil
      @text = {}
      @html = {}
      @variables = []
      @personalization = []
      @attachments = []
      @tags = []
      @send_at = send_at
    end

    def add_recipients(recipients)
      @recipients << recipients
    end

    def add_from(from)
      @from = from
    end

    def add_cc(ccs)
      @ccs << ccs
    end

    def add_bcc(bcc)
      @bcc << bcc
    end

    def add_reply_to(reply_to)
      @reply_to = reply_to
    end

    def add_subject(subject)
      @subject = subject
    end

    def add_text(text)
      @text = text
    end

    def add_html(html)
      @html = html
    end

    def add_variables(variables)
      @variables << variables
    end

    def add_personalization(personalization)
      @personalization << personalization
    end

    def add_template_id(template_id)
      @template_id = template_id
    end

    def add_tags(tags)
      @tags << tags
    end

    def add_attachment(content:, filename:, disposition:)
      data = File.read(content.to_s)
      encoded = Base64.strict_encode64(data)
      @attachments << {
        'content' => encoded,
        'filename' => filename,
        'disposition' => disposition
      }
    end

    def add_send_at(send_at)
      @send_at = send_at
    end

    def send
      message = {
        'from' => @from,
        'to' => @recipients,
        'cc' => @ccs,
        'bcc' => @bcc,
        'reply_to' => @reply_to,
        'subject' => @subject,
        'text' => @text,
        'html' => @html,
        'variables' => @variables,
        'personalization' => @personalization,
        'template_id' => @template_id,
        'attachments' => @attachments,
        'send_at' => @send_at,
        'tags' => @tags
      }

      client.http.post("#{API_URL}/email", json: message.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {} })
    end
  end
end
