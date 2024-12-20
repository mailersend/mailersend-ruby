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

RSpec.describe Mailersend::Webhooks do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:webhooks) { Mailersend::Webhooks.new(client) }

  it 'returns a list of webhooks' do
    VCR.use_cassette('webhooks/webhooks_list') do
      response = webhooks.list(domain_id: 'jpzkmgq7e5vl059v')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single webhook' do
    VCR.use_cassette('webhooks/webhooks_single') do
      response = webhooks.single(webhook_id: '3vz9dlej514kj50y')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'creates a new webhook' do
    VCR.use_cassette('webhooks/webhooks_create') do
      response = webhooks.create(
        url: 'https://example.com/webhook',
        name: 'Test Webhook',
        events: ['activity.sent', 'activity.delivered'],
        domain_id: 'jpzkmgq7e5vl059v',
        enabled: true
      )
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes a webhook' do
    VCR.use_cassette('webhooks/webhooks_delete') do
      response = webhooks.delete(webhook_id: '3vz9dlej514kj50y')

      expect(response.status).to eq(204)
    end
  end
end
