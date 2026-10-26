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
        from: '48600000001',
        type: %w[text image],
        date_from: 1_790_000_000,
        date_to: 1_790_086_400,
        page: 1,
        limit: 25
      )
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
      expect(parsed_response['data'][0]['meta']['body']).to eq('Hello, I would like to check my order status.')
      expect(parsed_response['data'][1]).not_to have_key('context')
      expect(parsed_response['links']['last']).to be_nil
      expect(parsed_response['meta']).not_to have_key('total')
    end
  end

  it 'returns a single WhatsApp inbound message' do
    VCR.use_cassette('whatsapp_inbound_messages/whatsapp_inbound_messages_get') do
      response = whatsapp_inbound_messages.get(whatsapp_inbound_message_id: '62f114a3165fe0d8db0288d1')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']['meta']['reply_type']).to eq('list_reply')
      expect(parsed_response['data']['context']['message_id']).to start_with('wamid.')
    end
  end
end
