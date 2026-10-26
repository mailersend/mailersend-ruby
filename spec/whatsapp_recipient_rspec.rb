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

RSpec.describe Mailersend::WhatsAppRecipient do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:whatsapp_recipient) { Mailersend::WhatsAppRecipient.new(client) }

  it 'returns a list of WhatsApp recipients' do
    VCR.use_cassette('whatsapp_recipient/whatsapp_recipient_list', match_requests_on: %i[method host path query]) do
      response = whatsapp_recipient.list(status: 'active', phone_number: '48600000001', page: 1, limit: 25)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
      expect(parsed_response['data'][0]).not_to have_key('bsuid')
      expect(parsed_response['links']['last']).to be_nil
      expect(parsed_response['meta']).not_to have_key('total')
    end
  end

  it 'returns a single WhatsApp recipient' do
    VCR.use_cassette('whatsapp_recipient/whatsapp_recipient_get') do
      response = whatsapp_recipient.get(whatsapp_recipient_id: '67f91abe2202f37055402301')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']['items']).to be_an(Array)
      expect(parsed_response['data']['items'][0]['whatsapp_message_id']).to eq('67f91abd69f79df391e9d78d')
    end
  end
end
