require 'rspec'
require 'vcr'
require 'json'

VCR.configure do |config|
  config.cassette_library_dir = './fixtures'
  config.hook_into :webmock
  config.filter_sensitive_data('<AUTH>') do |interaction|
    interaction.request.headers['Authorization'][0]
  end
end

RSpec.describe Mailersend::Suppressions do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:suppressions) { Mailersend::Suppressions.new(client) }

  it 'returns the blocklist' do
    VCR.use_cassette('suppressions/suppressions_get_from_blocklist') do
      response = suppressions.get_from_blocklist
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns hard bounces' do
    VCR.use_cassette('suppressions/suppressions_get_hard_bounces') do
      response = suppressions.get_hard_bounces
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns spam complaints' do
    VCR.use_cassette('suppressions/suppressions_get_spam_complaints') do
      response = suppressions.get_spam_complaints
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns unsubscribes' do
    VCR.use_cassette('suppressions/suppressions_get_unsubscribes') do
      response = suppressions.get_unsubscribes
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'adds to blocklist' do
    VCR.use_cassette('suppressions/suppressions_add_to_blocklist') do
      response = suppressions.add_to_blocklist(recipients: ['test@mailerlite.com'])
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'adds to hard bounces' do
    VCR.use_cassette('suppressions/suppressions_add_to_hard_bounces') do
      response = suppressions.add_to_hard_bounces(domain_id: 'jpzkmgq7e5vl059v', recipients: ['test@mailerlite.com'])
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'adds to spam complaints' do
    VCR.use_cassette('suppressions/suppressions_add_to_spam_complaints') do
      response = suppressions.add_to_spam_complaints(domain_id: 'jpzkmgq7e5vl059v', recipients: ['test@mailerlite.com'])
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'adds to unsubscribers' do
    VCR.use_cassette('suppressions/suppressions_add_to_unsubscribers') do
      response = suppressions.add_to_unsubscribers(domain_id: 'jpzkmgq7e5vl059v', recipients: ['test@mailerlite.com'])
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'deletes from blocklist' do
    VCR.use_cassette('suppressions/suppressions_delete_from_blocklist') do
      response = suppressions.delete_from_blocklist(domain_id: 'jpzkmgq7e5vl059v', ids: ['6764599b1cc3ea355ad717a0'])
      expect(response.status).to eq(200)
    end
  end

  it 'deletes from hard bounces' do
    VCR.use_cassette('suppressions/suppressions_delete_from_hard_bounces') do
      response = suppressions.delete_from_hard_bounces(domain_id: 'jpzkmgq7e5vl059v', ids: ['676457b042328d3c98db7600'])
      expect(response.status).to eq(200)
    end
  end

  it 'deletes from spam complaints' do
    VCR.use_cassette('suppressions/suppressions_delete_from_spam_complaints') do
      response = suppressions.delete_from_spam_complaints(domain_id: 'jpzkmgq7e5vl059v', ids: ['676457b1ee359d18093fcb99'])
      expect(response.status).to eq(200)
    end
  end

  it 'deletes from unsubscribers' do
    VCR.use_cassette('suppressions/suppressions_delete_from_unsubscribers') do
      response = suppressions.delete_from_unsubscribers(domain_id: 'jpzkmgq7e5vl059v', ids: ['676457b1252f59f004ea2bac'])
      expect(response.status).to eq(200)
    end
  end
end
