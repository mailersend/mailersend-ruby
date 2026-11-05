# frozen_string_literal: true

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

RSpec.describe Mailersend::Account do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:account) { Mailersend::Account.new(client) }

  it 'returns the account' do
    VCR.use_cassette('account/account_get') do
      response = account.get_account
      data = JSON.parse(response.body)['data']

      expect(response.status).to eq(200)
      expect(response.uri.to_s).to eq('https://api.mailersend.com/v1/account')
      expect(data).to include('name' => 'Acme Inc', 'status' => 'approved', 'plan_type' => 'starter', 'data_retention_days' => 7)
      expect(data['emails']).to eq('sent' => 12_000, 'received' => 430, 'limit' => -1)
      expect(data['rate_limits']).to eq('general' => 60, 'email' => 120, 'bulk_email' => 10, 'activity' => 10)
      expect(data['resources']).to include('domains' => { 'used' => 3, 'limit' => 10 }, 'free_accountant_seat' => { 'used' => 0, 'limit' => 0 })
      expect(data['addons']).to include('whatsapp' => { 'sent' => 800, 'limit' => 1000 }, 'sms' => { 'sent' => 120, 'received' => 30, 'limit' => -1 })
      expect(data['addons']).to include('phone_numbers' => 1, 'domain_spaces' => 2, 'data_retention_days' => 30, 'dedicated_ips' => 0)
    end
  end

  it 'returns the account without a WhatsApp add-on' do
    VCR.use_cassette('account/account_get_without_whatsapp') do
      data = JSON.parse(account.get_account.body)['data']

      expect(data['addons']).to include('whatsapp' => nil)
      expect(data['resources']).to include('free_accountant_seat' => { 'used' => 1, 'limit' => 1 }, 'webhooks' => { 'used' => 0, 'limit' => nil })
    end
  end
end
