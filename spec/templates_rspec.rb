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

RSpec.describe Mailersend::Templates do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:templates) { Mailersend::Templates.new(client) }

  it 'returns a list of templates' do
    VCR.use_cassette('templates/templates_list') do
      response = templates.list(domain_id: 'zkq340ezdqkgd796', page: 1, limit: 10)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single template' do
    VCR.use_cassette('templates/templates_single') do
      response = templates.single(template_id: 'pq3enl6v607g2vwr')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes a template' do
    VCR.use_cassette('templates/templates_delete') do
      response = templates.delete(template_id: 'z3m5jgrow5zgdpyo')

      expect(response.status).to eq(200)
    end
  end
end
