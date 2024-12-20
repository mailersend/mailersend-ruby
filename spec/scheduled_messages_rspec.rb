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

RSpec.describe Mailersend::ScheduledMessages do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:scheduled_messages) { Mailersend::ScheduledMessages.new(client) }

  it 'returns a list of scheduled messages' do
    VCR.use_cassette('scheduled_messages/scheduled_messages_get_list') do
      response = scheduled_messages.get_list
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single scheduled message' do
    VCR.use_cassette('scheduled_messages/scheduled_messages_get_single') do
      response = scheduled_messages.get_single(message_id: '6764a963c5b6195e097987ca')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes a scheduled message' do
    VCR.use_cassette('scheduled_messages/scheduled_messages_delete') do
      response = scheduled_messages.delete(message_id: '6764a963c5b6195e097987ca')

      expect(response.status).to eq(204)
    end
  end
end
