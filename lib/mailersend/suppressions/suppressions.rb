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

    def get_from_blocklist(domain_id: nil)
      response = client.http.get("#{API_URL}/suppressions/blocklist")
      puts response
    end
  
    def get_hard_bounces(domain_id: nil)
      response = client.http.get("#{API_URL}/suppressions/hard-bounces")
      puts response
    end
  
    def get_spam_complaints(domain_id: nil)
      response = client.http.get("#{API_URL}/suppressions/spam-complaints")
      puts response
    end
  
    def get_unsubscribes(domain_id: nil)
      response = client.http.get("#{API_URL}/suppressions/unsubscribes")
      puts response
    end
  
    def add_to_blocklist(domain_id: nil, recipients: nil, patterns: nil)
      hash = {
        'recipients' => recipients,
        'patterns' => patterns
      }
      response = client.http.post("#{API_URL}/suppressions/blocklist", json: hash.compact)
      puts response
    end
  
    def delete_from_blocklist(ids: nil)
      hash = {
        'ids' => ids
      }
      response = client.http.delete("#{API_URL}/suppressions/blocklist", json: hash.compact)
      puts response
    end
  
    def add_to_hard_bounces(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      response = client.http.post("#{API_URL}/suppressions/hard-bounces", json: hash.compact)
      puts response
    end
  
    def delete_from_hard_bounces(ids: nil)
      hash = {
        'ids' => ids
      }
      response = client.http.delete("#{API_URL}/suppressions/hard-bounces", json: hash.compact)
      puts response
    end
  
    def add_to_spam_complaints(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      response = client.http.post("#{API_URL}/suppressions/spam-complaints", json: hash.compact)
      puts response
    end
  
    def delete_from_spam_complaints(ids: nil)
      hash = {
        'ids' => ids
      }
      response = client.http.delete("#{API_URL}/suppressions/spam-complaints", json: hash.compact)
      puts response
    end
  
    def add_to_unsubscribers(domain_id: nil, recipients: nil)
      hash = {
        'domain_id' => domain_id,
        'recipients' => recipients
      }
      response = client.http.post("#{API_URL}/suppressions/unsubscribes", json: hash.compact)
      puts response
    end
  
    def delete_from_unsubscribers(ids: nil)
      hash = {
        'ids' => ids
      }
      response = client.http.delete("#{API_URL}/suppressions/unsubscribes", json: hash.compact)
      puts response
    end
  end
end