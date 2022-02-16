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
      client.http.get("#{API_URL}/suppressions/blocklist")
    end

    def get_hard_bounces(*)
      client.http.get("#{API_URL}/suppressions/hard-bounces")
    end

    def get_spam_complaints(*)
      client.http.get("#{API_URL}/suppressions/spam-complaints")
    end

    def get_unsubscribes(*)
      client.http.get("#{API_URL}/suppressions/unsubscribes")
    end

    def add_to_blocklist(recipients: nil, patterns: nil)
      hash = {
        'recipients' => recipients,
        'patterns' => patterns
      }
      client.http.post("#{API_URL}/suppressions/blocklist", json: hash.compact)
    end

    def delete_from_blocklist(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{API_URL}/suppressions/blocklist", json: hash.compact)
    end

    def add_to_hard_bounces(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      client.http.post("#{API_URL}/suppressions/hard-bounces", json: hash.compact)
    end

    def delete_from_hard_bounces(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{API_URL}/suppressions/hard-bounces", json: hash.compact)
    end

    def add_to_spam_complaints(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      client.http.post("#{API_URL}/suppressions/spam-complaints", json: hash.compact)
    end

    def delete_from_spam_complaints(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{API_URL}/suppressions/spam-complaints", json: hash.compact)
    end

    def add_to_unsubscribers(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      client.http.post("#{API_URL}/suppressions/unsubscribes", json: hash.compact)
    end

    def delete_from_unsubscribers(domain_id: nil, ids: nil, all: nil)
      hash = {
        'domain_id' => domain_id,
        'ids' => ids,
        'all' => all
      }
      client.http.delete("#{API_URL}/suppressions/unsubscribes", json: hash.compact)
    end
  end
end
