require 'rspec'
require 'vcr'
require 'json'

VCR.configure do |config|
  config.cassette_library_dir = './fixtures/bulk_email'
  config.hook_into :webmock
  config.filter_sensitive_data('<AUTH>') do |interaction|
    interaction.request.headers['Authorization'][0]
  end
end

RSpec.describe Mailersend::BulkEmail do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:bulk_email) { Mailersend::BulkEmail.new(client) }

  it 'sends bulk email' do
    VCR.use_cassette('bulk_email_send') do
      bulk_email.instance_variable_set(:@messages, [
                                         {
                                           'from' => 'sender@test-sdk.com',
                                           'to' => ['test@mailerlite.com'],
                                           'subject' => 'Test Bulk Email',
                                           'text' => 'This is a test bulk email.'
                                         }
                                       ])
      response = bulk_email.send
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(202)
      expect(parsed_response).to be_a(Hash)
    end
  end

  it 'gets bulk email status' do
    VCR.use_cassette('bulk_email_status') do
      response = bulk_email.get_bulk_status(bulk_email_id: '67618140bf85c862710f2c5a')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response).to be_a(Hash)
    end
  end
end
