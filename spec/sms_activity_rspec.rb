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

RSpec.describe Mailersend::SMSActivity do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:sms_activity) { Mailersend::SMSActivity.new(client) }

  it 'returns a list of SMS activities' do
    VCR.use_cassette('sms_activity/sms_activity_list') do
      response = sms_activity.list(page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end
end
