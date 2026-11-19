# frozen_string_literal: true

module Mailersend
  # SenderIdentity endpoint from MailerSend API
  class SenderIdentity
    attr_accessor :client,
                  :domain_id,
                  :identity_id,
                  :email,
                  :page,
                  :limit

    def initialize(client = Mailersend::Client.new)
      @client = client
      @domain_id = domain_id
      @identity_id = identity_id
      @email = email
      @page = page
      @limit = limit
    end

    def list(domain_id: nil, page: nil, limit: nil)
      hash = {
        'domain_id' => domain_id,
        'page' => page,
        'limit' => limit
      }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: "#{client.api_path}/identities",
                                       query: URI.encode_www_form(hash.compact)))
    end

    def single(identity_id:)
      hash = {
        'identity_id' => identity_id
      }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: "#{client.api_path}/identities/#{identity_id}",
                                       query: URI.encode_www_form(hash.compact)))
    end

    def single_by_email(email:)
      hash = {
        'email' => email
      }
      client.http.get(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: "#{client.api_path}/identities/email/#{email}",
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
      client.http.post("#{client.api_base_url}/identities", json: hash.compact)
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
      client.http.put("#{client.api_base_url}/identities/#{identity_id}", json: hash.compact)
    end

    def update_by_email(email:, domain_id: nil, name: nil, reply_to_email: nil, reply_to_name: nil, add_note: nil, personal_note: nil)
      hash = {
        'domain_id' => domain_id,
        'name' => name,
        'email' => email,
        'reply_to_email' => reply_to_email,
        'reply_to_name' => reply_to_name,
        'add_note' => add_note,
        'personal_note' => personal_note
      }
      client.http.put("#{client.api_base_url}/identities/email/#{email}", json: hash.compact)
    end

    def delete(identity_id:)
      client.http.delete(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: "#{client.api_path}/identities/#{identity_id}"))
    end

    def delete_by_email(email:)
      client.http.delete(URI::HTTPS.build(host: MAILERSEND_API_BASE_HOST, path: "#{client.api_path}/identities/email/#{email}"))
    end
  end
end
