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

RSpec.describe Mailersend::SMSInbounds do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:sms_inbounds) { Mailersend::SMSInbounds.new(client) }

  it 'returns a list of SMS inbounds' do
    VCR.use_cassette('sms_inbounds/sms_inbounds_list_sms_inbounds') do
      response = sms_inbounds.list(page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single SMS inbound route' do
    VCR.use_cassette('sms_inbounds/sms_inbounds_get_sms_inbound_route') do
      response = sms_inbounds.get_sms_inbound_route(sms_inbound_id: '6vywj2lpml7oqzd1')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'adds a new SMS inbound route' do
    VCR.use_cassette('sms_inbounds/sms_inbounds_add_sms_inbound_route') do
      sms_inbounds.settings = {
        'sms_number_id' => '0p7kx4xd7el9yjre',
        'forward_url' => 'https://mailersend.com',
        'name' => 'my-inbound-route',
        'events' => ['sms.sent', 'sms.delivered']
      }
      response = sms_inbounds.add_sms_inbound_route
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'updates an SMS inbound route' do
    VCR.use_cassette('sms_inbounds/sms_inbounds_update_sms_inbound_route') do
      sms_inbounds.settings = {
        'sms_number_id' => '0p7kx4xd7el9yjre',
        'forward_url' => 'https://mailersend.com',
        'name' => 'my-inbound-route',
        'events' => ['sms.sent', 'sms.delivered']

      }
      response = sms_inbounds.update_sms_inbound_route(sms_inbound_id: '0p7kx4xw0eg9yjre')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes an SMS inbound route' do
    VCR.use_cassette('sms_inbounds/sms_inbounds_delete_sms_inbound_route') do
      response = sms_inbounds.delete_sms_inbound_route(sms_inbound_id: '0p7kx4xw0eg9yjre')

      expect(response.status).to eq(204)
    end
  end
end
