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

RSpec.describe Mailersend::WhatsAppMessages do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:whatsapp_messages) { Mailersend::WhatsAppMessages.new(client) }

  it 'returns a list of WhatsApp messages' do
    VCR.use_cassette('whatsapp_messages/whatsapp_messages_list', match_requests_on: %i[method host path query]) do
      response = whatsapp_messages.list(
        whatsapp_account_id: '3enl6x27wmrxrl2v',
        from: '15550001234',
        template_id: '23zxk54v6gjy6v7m',
        date_from: 1_791_936_000,
        date_to: 1_792_022_400,
        page: 1,
        limit: 25
      )
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
      expect(parsed_response['data'][0]['to']).to eq(%w[48600000001 48600000002])
      expect(parsed_response['data'][0]).not_to have_key('items')
      expect(parsed_response['links']['last']).to be_nil
      expect(parsed_response['meta']).not_to have_key('total')
      expect(parsed_response['meta']).not_to have_key('last_page')
    end
  end

  it 'returns a single WhatsApp message' do
    VCR.use_cassette('whatsapp_messages/whatsapp_messages_get') do
      response = whatsapp_messages.get(whatsapp_message_id: '67f91abd69f79df391e9d78d')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']['items']).to be_an(Array)
      expect(parsed_response['data']['items'].map { |item| item['status'] }).to eq(%w[read failed])
    end
  end
end
