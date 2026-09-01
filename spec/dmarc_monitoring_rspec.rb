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

RSpec.describe Mailersend::DmarcMonitoring do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:dmarc) { Mailersend::DmarcMonitoring.new(client) }

  it 'returns a list of monitors' do
    VCR.use_cassette('dmarc_monitoring/list') do
      response = dmarc.list
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'creates a monitor' do
    VCR.use_cassette('dmarc_monitoring/create') do
      response = dmarc.create(domain_id: 'example_domain_id')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'updates a monitor' do
    VCR.use_cassette('dmarc_monitoring/update') do
      response = dmarc.update(monitor_id: 'example_monitor_id', wanted_dmarc_record: 'v=DMARC1; p=reject;')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_a(Hash)
    end
  end

  it 'deletes a monitor' do
    VCR.use_cassette('dmarc_monitoring/delete') do
      response = dmarc.delete(monitor_id: 'example_monitor_id')

      expect(response.status).to eq(204)
    end
  end

  it 'returns aggregated report' do
    VCR.use_cassette('dmarc_monitoring/report') do
      response = dmarc.report(monitor_id: 'example_monitor_id')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns IP-specific report' do
    VCR.use_cassette('dmarc_monitoring/report_by_ip') do
      response = dmarc.report_by_ip(monitor_id: 'example_monitor_id', ip: '1.2.3.4')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'returns report sources' do
    VCR.use_cassette('dmarc_monitoring/report_sources') do
      response = dmarc.report_sources(monitor_id: 'example_monitor_id')
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to be_an(Array)
    end
  end

  it 'marks an IP as favorite' do
    VCR.use_cassette('dmarc_monitoring/add_favorite') do
      response = dmarc.add_favorite(monitor_id: 'example_monitor_id', ip: '1.2.3.4')

      expect(response.status).to eq(200)
    end
  end

  it 'removes an IP from favorites' do
    VCR.use_cassette('dmarc_monitoring/remove_favorite') do
      response = dmarc.remove_favorite(monitor_id: 'example_monitor_id', ip: '1.2.3.4')

      expect(response.status).to eq(200)
    end
  end
end
