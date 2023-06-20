# frozen_string_literal: true

module Mailersend
  # SenderIdentity endpoint from MailerSend API
  class SenderIdentity
    attr_accessor :client,
                  :domain_id,
                  :identity_id,
                  :page,
                  :limit

    def initialize(client = Mailersend::Client.new)
      @client = client
      @domain_id = domain_id
      @identity_id = identity_id
      @page = page
      @limit = limit
    end

    def list(domain_id: nil, page: nil, limit: nil)
      hash = {
        'domain_id' => domain_id,
        'page' => page,
        'limit' => limit
      }
      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: '/v1/identities',
                                       query: URI.encode_www_form(hash.compact)))
    end

    def single(identity_id:)
      hash = {
        'identity_id' => identity_id
      }
      client.http.get(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/identities/#{identity_id}",
                                       query: URI.encode_www_form(hash.compact)))
    end

    def add(domain_id: nil, name: nil, email: nil, reply_to_email: nil, reply_to_name: nil, add_note: nil, personal_note: nil)
      hash = {
        'domain_id' => domain_id,
        'name' => name,
        'email' => email,
        'reply_to_email' => reply_to_email,
        'reply_to_name' => reply_to_name,
        'add_note' => add_note,
        'personal_note' => personal_note
      }
      client.http.post("#{API_URL}/identities", json: hash.compact)
    end

    def update(identity_id:, domain_id: nil, name: nil, email: nil, reply_to_email: nil, reply_to_name: nil, add_note: nil, personal_note: nil)
      hash = {
        'domain_id' => domain_id,
        'name' => name,
        'email' => email,
        'reply_to_email' => reply_to_email,
        'reply_to_name' => reply_to_name,
        'add_note' => add_note,
        'personal_note' => personal_note
      }
      client.http.put("#{API_URL}/identities/#{identity_id}", json: hash.compact)
    end

    def delete(identity_id:)
      client.http.delete(URI::HTTPS.build(host: API_BASE_HOST, path: "/v1/identities/#{identity_id}"))
    end
  end
end
