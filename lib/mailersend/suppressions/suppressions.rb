# frozen_string_literal: true

module Mailersend
  # Suppressions endpoint from MailerSend API.
  class Suppressions
    attr_accessor :client,
                  :page,
                  :limit,
                  :recipient_id

    def initialize(client = Mailersend::Client.new)
      @client = client
      @page = page
      @limit = limit
      @recipient_id = recipient_id
    end

    def get_from_blocklist(*)
      client.http.get("#{client.api_base_url}/suppressions/blocklist")
    end

    def get_hard_bounces(*)
      client.http.get("#{client.api_base_url}/suppressions/hard-bounces")
    end

    def get_spam_complaints(*)
      client.http.get("#{client.api_base_url}/suppressions/spam-complaints")
    end

    def get_unsubscribes(*)
      client.http.get("#{client.api_base_url}/suppressions/unsubscribes")
    end

    def add_to_blocklist(recipients: nil, patterns: nil)
      hash = {
        'recipients' => recipients,
        'patterns' => patterns
      }
      client.http.post("#{client.api_base_url}/suppressions/blocklist", json: hash.compact)
    end

    def delete_from_blocklist(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{client.api_base_url}/suppressions/blocklist", json: hash.compact)
    end

    def add_to_hard_bounces(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      client.http.post("#{client.api_base_url}/suppressions/hard-bounces", json: hash.compact)
    end

    def delete_from_hard_bounces(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{client.api_base_url}/suppressions/hard-bounces", json: hash.compact)
    end

    def add_to_spam_complaints(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      client.http.post("#{client.api_base_url}/suppressions/spam-complaints", json: hash.compact)
    end

    def delete_from_spam_complaints(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{client.api_base_url}/suppressions/spam-complaints", json: hash.compact)
    end

    def add_to_unsubscribers(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      client.http.post("#{client.api_base_url}/suppressions/unsubscribes", json: hash.compact)
    end

    def delete_from_unsubscribers(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{client.api_base_url}/suppressions/unsubscribes", json: hash.compact)
    end
  end
end
