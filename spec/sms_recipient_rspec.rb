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

RSpec.describe Mailersend::SMSRecipient do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:sms_recipient) { Mailersend::SMSRecipient.new(client) }

  it 'returns a list of SMS recipients' do
    VCR.use_cassette('sms_recipient/sms_recipient_list') do
      response = sms_recipient.list(page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single SMS recipient' do
    VCR.use_cassette('sms_recipient/sms_recipient_get') do
      response = sms_recipient.get(sms_recipient_id: '627e7503d30078fb2208cc83')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'updates an SMS recipient' do
    VCR.use_cassette('sms_recipient/sms_recipient_update') do
      response = sms_recipient.update(sms_recipient_id: '627e7503d30078fb2208cc83', status: 'active')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end
end
