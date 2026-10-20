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

RSpec.describe Mailersend::WhatsAppTemplates do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:whatsapp_templates) { Mailersend::WhatsAppTemplates.new(client) }

  it 'returns a list of WhatsApp templates' do
    VCR.use_cassette('whatsapp_templates/whatsapp_templates_list', match_requests_on: %i[method host path query]) do
      response = whatsapp_templates.list(
        whatsapp_account_id: '3enl6x27wmrxrl2v',
        status: 'approved',
        category: 'UTILITY',
        language: 'en_US',
        page: 1,
        limit: 25
      )
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
      expect(parsed_response['data'][1]['components']['header']).to be_nil
      expect(parsed_response['links']['last']).to be_nil
      expect(parsed_response['meta']).not_to have_key('total')
    end
  end

  it 'returns a single WhatsApp template' do
    VCR.use_cassette('whatsapp_templates/whatsapp_templates_get') do
      response = whatsapp_templates.get(whatsapp_template_id: '23zxk54v6gjy6v7m')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']['name']).to eq('order_confirmation')
      expect(parsed_response['data']['components']['buttons'][0]['url']).to eq('https://shop.example.com/{{1}}')
    end
  end
end
