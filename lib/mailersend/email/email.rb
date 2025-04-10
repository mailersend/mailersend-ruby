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
                  :headers,
                  :list_unsubscribe,
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
      @headers = {}
      @list_unsubscribe = nil
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
      # content: Can be one of the following:
      # file_path(String) i.e. 'app/Sample-jpg-image-50kb.jpeg'
      # Base64 encoded string (String)
      # Supported types are: https://developers.mailersend.com/api/v1/email.html#supported-file-types

      content_string = content.to_s
      if File.readable?(content_string)
        data = File.read(content_string)
        base64_encoded = Base64.strict_encode64(data)
      else
        base64_encoded = content_string
      end
      @attachments << { 'content' => base64_encoded, 'filename' => filename, 'disposition' => disposition }
    end

    def add_headers(headers)
      @headers = headers
    end

    def add_list_unsubscribe(list_unsubscribe)
      @list_unsubscribe = list_unsubscribe
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
        'headers' => @headers,
        'list_unsubscribe' => @list_unsubscribe,
        'send_at' => @send_at,
        'tags' => @tags
      }

      client.http.post("#{MAILERSEND_API_URL}/email", json: message.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {} })
    end
  end
end
