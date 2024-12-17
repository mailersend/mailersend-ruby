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

RSpec.describe Mailersend::APIQuota do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:api_quota) { Mailersend::APIQuota.new(client) }

  it 'returns the API quota' do
    VCR.use_cassette('api_quota/api_quota_get') do
      response = api_quota.get_api_quota
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response).to be_a(Hash)
      expect(parsed_response).to have_key('quota')
      expect(parsed_response).to have_key('remaining')
      expect(parsed_response).to have_key('reset')
    end
  end
end
