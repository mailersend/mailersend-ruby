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

RSpec.describe Mailersend::SMSMessages do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:sms_messages) { Mailersend::SMSMessages.new(client) }

  it 'returns a list of SMS messages' do
    VCR.use_cassette('sms_messages/sms_messages_list_sms_messages') do
      response = sms_messages.list(page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end
end
