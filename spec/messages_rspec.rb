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

RSpec.describe Mailersend::Messages do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:messages) { Mailersend::Messages.new(client) }

  it 'returns a list of messages' do
    VCR.use_cassette('messages/messages_list_messages') do
      response = messages.list(page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single message' do
    VCR.use_cassette('messages/messages_single_message') do
      response = messages.single(message_id: '676184e34aed90153c5efa6f')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end
end
