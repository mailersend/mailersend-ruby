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

RSpec.describe Mailersend::WhatsAppInboundMessages do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:whatsapp_inbound_messages) { Mailersend::WhatsAppInboundMessages.new(client) }

  it 'returns a list of WhatsApp inbound messages' do
    VCR.use_cassette('whatsapp_inbound_messages/whatsapp_inbound_messages_list', match_requests_on: %i[method host path query]) do
      response = whatsapp_inbound_messages.list(
        whatsapp_account_id: '3enl6x27wmrxrl2v',
        type: %w[text image],
        date_from: 1_790_000_000,
        date_to: 1_790_086_400,
        page: 1,
        limit: 25
      )
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single WhatsApp inbound message' do
    VCR.use_cassette('whatsapp_inbound_messages/whatsapp_inbound_messages_get') do
      response = whatsapp_inbound_messages.get(whatsapp_inbound_message_id: '62f114a3165fe0d8db0288d1')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end
end
