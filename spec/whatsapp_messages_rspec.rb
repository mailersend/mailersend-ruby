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
    VCR.use_cassette('whatsapp_messages/whatsapp_messages_list') do
      response = whatsapp_messages.list(page: 1, limit: 25)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single WhatsApp message' do
    VCR.use_cassette('whatsapp_messages/whatsapp_messages_get') do
      response = whatsapp_messages.get(whatsapp_message_id: '67f91abd69f79df391e9d78d')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']['recipients']).to be_an(Array)
    end
  end
end
