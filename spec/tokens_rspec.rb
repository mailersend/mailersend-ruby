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

RSpec.describe Mailersend::Tokens do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:tokens) { Mailersend::Tokens.new(client) }

  it 'creates a new token' do
    VCR.use_cassette('tokens/tokens_create') do
      response = tokens.create(name: 'Test Token', scopes: ['email_full'], domain_id: 'example_domain_id')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Hash)
    end
  end

  it 'updates a token status' do
    VCR.use_cassette('tokens/tokens_update') do
      response = tokens.update(token_id: '1dd8e323b92f9953069f9647ca5929a24674e2f972d85734b27de16cd06360256054a070b783c272', status: 'pause')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response).to be_a(Hash)
    end
  end

  it 'deletes a token' do
    VCR.use_cassette('tokens/tokens_delete') do
      response = tokens.delete(token_id: '1dd8e323b92f9953069f9647ca5929a24674e2f972d85734b27de16cd06360256054a070b783c272')

      expect(response.status).to eq(200)
    end
  end
end
