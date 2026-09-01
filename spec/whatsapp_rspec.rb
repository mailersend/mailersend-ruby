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

RSpec.describe Mailersend::WhatsApp do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:whatsapp) { Mailersend::WhatsApp.new(client) }

  it 'sends a WhatsApp message' do
    VCR.use_cassette('whatsapp/whatsapp_send') do
      whatsapp.add_from('15550001234')
      whatsapp.add_to('+48600000001')
      whatsapp.add_template_id('23zxk54v6gjy6v7m')

      response = whatsapp.send
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(202)
      expect(parsed_response['data']['id']).to eq('67f91abd69f79df391e9d78d')
    end
  end

  it 'includes the personalization in the request body when set' do
    # Cassette is matched on the request body, so this passes only when
    # the serialized payload contains the personalization field.
    VCR.use_cassette('whatsapp/whatsapp_send_personalization', match_requests_on: %i[method uri body]) do
      whatsapp.add_from('15550001234')
      whatsapp.add_to('+48600000001')
      whatsapp.add_template_id('23zxk54v6gjy6v7m')
      whatsapp.add_personalization(
        {
          'to' => '+48600000001',
          'data' => {
            'header' => ['Order #12345'],
            'body' => ['John', 'December 31, 2026'],
            'buttons' => ['orders/12345']
          }
        }
      )

      response = whatsapp.send
      expect(response.status).to eq(202)
    end
  end

  it 'sends to multiple recipients' do
    VCR.use_cassette('whatsapp/whatsapp_send_multiple_recipients', match_requests_on: %i[method uri body]) do
      whatsapp.add_from('15550001234')
      whatsapp.add_to('+48600000001')
      whatsapp.add_to('+48600000002')
      whatsapp.add_template_id('23zxk54v6gjy6v7m')

      response = whatsapp.send
      expect(response.status).to eq(202)
    end
  end
end
