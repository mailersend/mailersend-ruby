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

RSpec.describe Mailersend::Emails do
  let(:client) { Mailersend::Client.new(API_TOKEN) }
  let(:emails) { Mailersend::Emails.new(client) }

  # The three required arguments, reused by every example.
  let(:domain_id) { 'jpzkmgq7e5vl059v' }
  let(:date_from) { 1_756_252_800 }
  let(:date_to) { 1_756_339_200 }

  describe '#list' do
    # VCR matches on method + URI, so the `uri:` recorded in the cassette is itself the
    # assertion that `list` hits `v1/emails` with domain_id, date_from, date_to, limit and page.
    it 'returns a list of emails' do
      VCR.use_cassette('emails/emails_list_emails', match_requests_on: %i[method uri]) do
        response = emails.list(domain_id: domain_id, date_from: date_from, date_to: date_to, page: 1, limit: 10)
        parsed_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_response['data']).to be_an(Array)

        email = parsed_response['data'].first

        expect(email['id']).to eq('6a8fa9b1902fab56e0ce50dd')
        expect(email['from']).to eq('sender@example.com')
        expect(email['to']).to eq('rcpt@example.org')
        expect(email['status']).to eq('sent')
        expect(email['tags']).to eq(['newsletter'])
        expect(email['interaction']).to eq(['opened'])
        expect(email['suppression_reason']).to be_nil
        expect(email['headers']).to eq([{ 'name' => 'X-Custom', 'value' => 'foo' }])

        # List rows never carry content — it is only returned by `single`.
        expect(email['text']).to be_nil
        expect(email['html']).to be_nil

        expect(parsed_response['links']['first']).to eq('https://api.mailersend.com/v1/emails?page=1')
        expect(parsed_response['links']['last']).to be_nil
        expect(parsed_response['meta']['current_page']).to eq(1)
        expect(parsed_response['meta']['per_page']).to eq(10)
      end
    end

    it 'returns an empty page past the end of the result set' do
      VCR.use_cassette('emails/emails_list_emails_empty_page', match_requests_on: %i[method uri]) do
        response = emails.list(domain_id: domain_id, date_from: date_from, date_to: date_to, page: 2, limit: 10)
        parsed_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_response['data']).to eq([])
        expect(parsed_response['links']['prev']).to eq('https://api.mailersend.com/v1/emails?page=1')
        expect(parsed_response['links']['next']).to be_nil
        expect(parsed_response['meta']['current_page']).to eq(2)
        expect(parsed_response['meta']['from']).to be_nil
        expect(parsed_response['meta']['to']).to be_nil
      end
    end
  end

  describe '#single' do
    # The path is singular (`v1/email/{id}`) while `list` is plural (`v1/emails`); the cassette
    # URI pins that difference.
    it 'returns a single email with its recipient and activity' do
      VCR.use_cassette('emails/emails_single_email', match_requests_on: %i[method uri]) do
        response = emails.single(email_id: '6a8fa9b1902fab56e0ce50dd')
        parsed_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_response['data']).to be_a(Hash)
        expect(parsed_response['data']['id']).to eq('6a8fa9b1902fab56e0ce50dd')

        # `single` adds content, the recipient object and the activity array on top of a list row.
        expect(parsed_response['data']['text']).to eq('Welcome aboard.')
        expect(parsed_response['data']['html']).to eq('<p>Welcome aboard.</p>')
        expect(parsed_response['data']['recipient']).to be_a(Hash)
        expect(parsed_response['data']['recipient']['email']).to eq('rcpt@example.org')

        activity = parsed_response['data']['activity']

        expect(activity).to be_an(Array)
        expect(activity.length).to eq(3)
        expect(activity.first).to include('id', 'type', 'created_at')
        expect(activity.first['type']).to eq('opened')
        expect(activity.map { |event| event['type'] }).to eq(%w[opened delivered sent])
      end
    end
  end

  # These examples assert the URI the SDK builds rather than replaying a cassette, because query
  # serialization is the contract that matters most here: the API rejects a scalar `status` or
  # `interaction` with 422, so both must go out as repeated `status[]` / `interaction[]` params and
  # never as a single comma-joined value.
  describe 'query serialization' do
    let(:http) { double('http') }
    let(:requested_urls) { [] }

    before do
      allow(client).to receive(:http).and_return(http)
      allow(http).to receive(:get) { |url| requested_urls << url.to_s }
    end

    it 'sends status and interaction as repeated array params' do
      emails.list(domain_id: domain_id, date_from: date_from, date_to: date_to, limit: 10, page: 1,
                  status: %w[sent delivered], interaction: %w[opened clicked])

      expect(requested_urls.last).to eq(
        'https://api.mailersend.com/v1/emails' \
        '?domain_id=jpzkmgq7e5vl059v&date_from=1756252800&date_to=1756339200&limit=10&page=1' \
        '&status%5B%5D=sent&status%5B%5D=delivered' \
        '&interaction%5B%5D=opened&interaction%5B%5D=clicked'
      )

      # One key per value, and no comma-joined value anywhere (%2C is an encoded comma).
      expect(requested_urls.last.scan('status%5B%5D=').length).to eq(2)
      expect(requested_urls.last.scan('interaction%5B%5D=').length).to eq(2)
      expect(requested_urls.last).not_to include('%2C')
    end

    it 'sends a scalar status and interaction in array form too' do
      emails.list(domain_id: domain_id, date_from: date_from, date_to: date_to,
                  status: 'sent', interaction: 'opened')

      expect(requested_urls.last).to eq(
        'https://api.mailersend.com/v1/emails' \
        '?domain_id=jpzkmgq7e5vl059v&date_from=1756252800&date_to=1756339200' \
        '&status%5B%5D=sent&interaction%5B%5D=opened'
      )
    end

    it 'includes every optional filter when set' do
      emails.list(domain_id: domain_id, date_from: date_from, date_to: date_to, limit: 25, page: 2,
                  status: %w[sent], interaction: %w[opened], recipient_email: 'rcpt@example.org',
                  message_id: '6a8fa9b1902fab56e0ce50aa', template_id: '7nxe3yjmeq28vp0k',
                  subject: 'Welcome', tag: 'newsletter')

      expect(requested_urls.last).to eq(
        'https://api.mailersend.com/v1/emails' \
        '?domain_id=jpzkmgq7e5vl059v&date_from=1756252800&date_to=1756339200&limit=25&page=2' \
        '&status%5B%5D=sent&interaction%5B%5D=opened' \
        '&recipient_email=rcpt%40example.org&message_id=6a8fa9b1902fab56e0ce50aa' \
        '&template_id=7nxe3yjmeq28vp0k&subject=Welcome&tag=newsletter'
      )
    end

    it 'omits every optional filter that is nil' do
      emails.list(domain_id: domain_id, date_from: date_from, date_to: date_to)

      expect(requested_urls.last).to eq(
        'https://api.mailersend.com/v1/emails?domain_id=jpzkmgq7e5vl059v&date_from=1756252800&date_to=1756339200'
      )

      %w[limit page status interaction recipient_email message_id template_id subject tag].each do |param|
        expect(requested_urls.last).not_to include(param)
      end
    end

    it 'requests the singular v1/email/{id} path for a single email' do
      emails.single(email_id: '6a8fa9b1902fab56e0ce50dd')

      expect(requested_urls.last).to eq('https://api.mailersend.com/v1/email/6a8fa9b1902fab56e0ce50dd')
      expect(requested_urls.last).not_to include('/v1/emails/')
    end
  end
end
