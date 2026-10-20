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

RSpec.describe Mailersend::WhatsAppItems do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:whatsapp_items) { Mailersend::WhatsAppItems.new(client) }

  it 'returns a list of WhatsApp items' do
    VCR.use_cassette('whatsapp_items/whatsapp_items_list', match_requests_on: %i[method host path query]) do
      response = whatsapp_items.list(
        recipient: '48600000002',
        whatsapp_message_id: '67f91abd69f79df391e9d78d',
        status: %w[failed read],
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
      expect(parsed_response['data'][0]['status']).to eq('failed')
      expect(parsed_response['data'][0]['error_code']).to eq(131_026)
      expect(parsed_response['links']['last']).to be_nil
      expect(parsed_response['meta']).not_to have_key('total')
    end
  end

  it 'returns a single WhatsApp item' do
    VCR.use_cassette('whatsapp_items/whatsapp_items_get') do
      response = whatsapp_items.get(whatsapp_item_id: '67f91abe2202f3705540234a')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']['recipient']['id']).to eq('67f91abe2202f37055402301')
      expect(parsed_response['data']['activity'].map { |activity| activity['type'] }).to eq(%w[queued sent delivered read])
    end
  end
end
