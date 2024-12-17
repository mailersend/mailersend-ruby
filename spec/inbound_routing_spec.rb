require 'rspec'
require 'vcr'
require 'json'

VCR.configure do |config|
  config.cassette_library_dir = './fixtures/inbound_routing'
  config.hook_into :webmock
  config.filter_sensitive_data('<AUTH>') do |interaction|
    interaction.request.headers['Authorization'][0]
  end
end

RSpec.describe Mailersend::InboundRouting do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:inbound_routing) { Mailersend::InboundRouting.new(client) }

  it 'returns a list of inbound routes' do
    VCR.use_cassette('inbound_routes_list') do
      response = inbound_routing.get_inbound_routes
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single inbound route' do
    VCR.use_cassette('inbound_route_single') do
      response = inbound_routing.get_single_route(inbound_id: 'pr9084zw584w63dn')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes an inbound route' do
    VCR.use_cassette('inbound_route_delete') do
      response = inbound_routing.delete_route(inbound_id: '7dnvo4dkd6l5r86y')

      expect(response.status).to eq(204)
    end
  end
end
