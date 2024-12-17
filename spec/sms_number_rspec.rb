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

RSpec.describe Mailersend::SMSNumber do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:sms_number) { Mailersend::SMSNumber.new(client) }

  it 'returns a list of SMS numbers' do
    VCR.use_cassette('sms_number/sms_number_list') do
      response = sms_number.list(page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single SMS number' do
    VCR.use_cassette('sms_number/sms_number_get') do
      response = sms_number.get(sms_number_id: '0p7kx4xd7el9yjre')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'updates an SMS number' do
    VCR.use_cassette('sms_number/sms_number_update') do
      response = sms_number.update(sms_number_id: '0p7kx4xd7el9yjre', paused: true)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes an SMS number' do
    VCR.use_cassette('sms_number/sms_number_delete') do
      response = sms_number.delete(sms_number_id: 'example_sms_number_id')

      expect(response.status).to eq(204)
    end
  end
end
