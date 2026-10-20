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

RSpec.describe Mailersend::WhatsAppActivities do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:whatsapp_activities) { Mailersend::WhatsAppActivities.new(client) }

  it 'returns a list of WhatsApp activities' do
    VCR.use_cassette('whatsapp_activities/whatsapp_activities_list', match_requests_on: %i[method host path query]) do
      response = whatsapp_activities.list(
        whatsapp_item_id: '67f91abe2202f3705540234a',
        whatsapp_message_id: '67f91abd69f79df391e9d78d',
        recipient: '48600000001',
        type: %w[delivered read],
        date_from: 1_791_936_000,
        date_to: 1_792_022_400,
        page: 1,
        limit: 25
      )
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
      expect(parsed_response['data'].map { |activity| activity['type'] }).to eq(%w[read delivered])
      expect(parsed_response['links']['last']).to be_nil
      expect(parsed_response['meta']).not_to have_key('total')
    end
  end
end
