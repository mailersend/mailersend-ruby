# frozen_string_literal: true

require 'rspec'

RSpec.describe Mailersend::Client do
  it 'defaults to the 2026-10 API version' do
    client = Mailersend::Client.new(API_TOKEN)

    expect(client.api_version).to eq('2026-10')
    expect(client.api_path).to eq('/2026-10')
    expect(client.api_base_url).to eq('https://api.mailersend.com/2026-10')
  end

  it 'can stay on v1' do
    client = Mailersend::Client.new(API_TOKEN, api_version: 'v1')

    expect(client.api_path).to eq('/v1')
    expect(client.api_base_url).to eq('https://api.mailersend.com/v1')
  end

  it 'accepts another dated version' do
    client = Mailersend::Client.new(API_TOKEN, api_version: '2027-04')

    expect(client.api_path).to eq('/2027-04')
    expect(client.api_base_url).to eq('https://api.mailersend.com/2027-04')
  end

  it 'raises on an invalid API version' do
    ['v2', '2026-13', '2026-1', '2026-10-01', '', nil].each do |api_version|
      expect { Mailersend::Client.new(API_TOKEN, api_version: api_version) }.to raise_error(ArgumentError)
    end
  end
end
