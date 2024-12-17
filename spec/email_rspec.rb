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

RSpec.describe Mailersend::Email do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:email) { Mailersend::Email.new(client) }

  it 'sends an email' do
    VCR.use_cassette('email/email_send') do
      email.from = { 'email' => 'sender@test-sdk.com', 'name' => 'Sender' }
      email.recipients = [{ 'email' => 'test@mailerlite.com', 'name' => 'Test' }]
      email.subject = 'Test Email'
      email.text = 'This is a test email.'
      email.html = '<p>This is a test email.</p>'

      response = email.send
      expect(response.status).to eq(202)
    end
  end
end
