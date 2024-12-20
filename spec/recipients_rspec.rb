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

RSpec.describe Mailersend::Recipients do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:recipients) { Mailersend::Recipients.new(client) }

  it 'returns a list of recipients' do
    VCR.use_cassette('recipients/recipients_list') do
      response = recipients.list(page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single recipient' do
    VCR.use_cassette('recipients/recipients_single') do
      response = recipients.single(recipient_id: '663cd8f984e4628b80b976a3')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes a recipient' do
    VCR.use_cassette('recipients/recipients_delete') do
      response = recipients.delete(recipient_id: '663cd8f984e4628b80b976a3')

      expect(response.status).to eq(204)
    end
  end
end
