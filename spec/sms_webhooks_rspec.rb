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

RSpec.describe Mailersend::SMSWebhooks do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:sms_webhooks) { Mailersend::SMSWebhooks.new(client) }

  it 'returns a list of SMS webhooks' do
    VCR.use_cassette('sms_webhooks/sms_webhooks_list_sms_webhooks') do
      response = sms_webhooks.list(sms_number_id: '0p7kx4xd7el9yjre')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single SMS webhook route' do
    VCR.use_cassette('sms_webhooks/sms_webhooks_get_sms_webhook_route') do
      response = sms_webhooks.get_sms_webhook_route(sms_webhook_id: '0r83ql3pzvgzw1jm')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'adds a new SMS webhook route' do
    VCR.use_cassette('sms_webhooks/sms_webhooks_add_sms_webhook_route') do
      sms_webhooks.settings = {
        'sms_number_id' => '0p7kx4xd7el9yjre',
        'name' => 'good-webhook',
        'url' => 'https://mailersend.net/webhook',
        'events' => ['sms.sent', 'sms.delivered']
      }
      response = sms_webhooks.add_sms_webhook_route
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'updates an SMS webhook route' do
    VCR.use_cassette('sms_webhooks/sms_webhooks_update_sms_webhook_route') do
      sms_webhooks.settings = {
        'url' => 'https://mailersend.net/updated_webhook',
        'events' => ['sms.sent', 'sms.delivered']
      }
      response = sms_webhooks.update_sms_webhook_route(sms_webhook_id: '0r83ql3pzvgzw1jm')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes an SMS webhook route' do
    VCR.use_cassette('sms_webhooks/sms_webhooks_delete_sms_webhook_route') do
      response = sms_webhooks.delete_sms_webhook_route(sms_webhook_id: '0r83ql3pzvgzw1jm')

      expect(response.status).to eq(204)
    end
  end
end
