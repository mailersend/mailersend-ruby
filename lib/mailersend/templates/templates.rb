# frozen_string_literal: true

module Mailersend
  # Templates endpoint from MailerSend API.
  class Templates
    attr_accessor :client,
                  :page,
                  :limit,
                  :template_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @template_id = template_id
    end

    def list(domain_id: nil, page: nil, limit: nil)
      hash = {
        "domain_id" => domain_id,
        "page" => page,
        "limit" => limit
      }

      response = client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/templates",
                                                  query: URI.encode_www_form(hash)))
      puts response
    end

    def single(template_id:)
      response = client.http.get("#{API_URL}/templates/#{template_id}")
      puts response
    end

    def delete(template_id:)
      response = client.http.delete("#{API_URL}/templates/#{template_id}")
      puts response
    end
  end
end
