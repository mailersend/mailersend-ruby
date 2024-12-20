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

RSpec.describe Mailersend::Activity do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:activity) { Mailersend::Activity.new(client) }

  it 'returns activity data' do
    VCR.use_cassette('activity/activity_get_activity') do
      response = activity.get(domain_id: 'jpzkmgq7e5vl059v', page: 1, limit: 10, date_from: '1734115200', date_to: '1734633600')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end
end
