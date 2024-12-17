require 'rspec'
require 'vcr'
require 'json'

VCR.configure do |config|
  config.cassette_library_dir = './fixtures/domains'
  config.hook_into :webmock
  config.filter_sensitive_data('<AUTH>') do |interaction|
    interaction.request.headers['Authorization'][0]
  end
end

RSpec.describe Mailersend::Domains do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:domains) { Mailersend::Domains.new(client) }

  it 'returns a list of domains' do
    VCR.use_cassette('domains_list') do
      response = domains.list
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns a single domain' do
    VCR.use_cassette('domains_single') do
      response = domains.single(domain_id: 'z3m5jgrdk7z4dpyo')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'adds a new domain' do
    VCR.use_cassette('domains_add') do
      response = domains.add(name: 'ourdomain.com')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes a domain' do
    VCR.use_cassette('domains_delete') do
      response = domains.delete(domain_id: 'zkq340ezdqkgd796')

      expect(response.status).to eq(204)
    end
  end

  it 'returns recipients for a domain' do
    VCR.use_cassette('domains_recipients') do
      response = domains.recipients(domain_id: '3yxj6lj1r05ldo2r')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'updates domain settings' do
    VCR.use_cassette('domains_settings') do
      response = domains.settings(domain_id: '3yxj6lj1r05ldo2r', send_paused: true)
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'returns DNS records for a domain' do
    VCR.use_cassette('domains_dns') do
      response = domains.dns(domain_id: 'jpzkmgq7e5vl059v')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Hash)
    end
  end

  it 'verifies a domain' do
    VCR.use_cassette('domains_verify') do
      response = domains.verify(domain_id: 'jpzkmgq7e5vl059v')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end
end
