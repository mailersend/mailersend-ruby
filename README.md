<a href="https://www.mailersend.com"><img src="https://www.mailersend.com/images/logo.svg" width="200px"/></a>

MailerSend Ruby SDK

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.txt)

- [Installation](#installation)
  - [Setup](#setup)
- [Usage](#usage)
  - [Email](#email)
    - [Send an email](#send-an-email)
    - [Add CC, BCC recipients](#add-cc-bcc-recipients)
    - [Send a template-based email](#send-a-template-based-email)
    - [Personalization](#personalization)
  - [Bulk Email](#bulk-email)
    - [Send bulk email](#send-bulk-email)
    - [Get bulk email status](#get-bulk-email-status)
  - [Tokens](#tokens)
    - [Create a token](#create-a-token)
    - [Update a token](#update-a-token)
    - [Delete a token](#delete-a-token)
    - [Send email with attachment](#send-email-with-attachment)
  - [Activity](#activity)
    - [Get a list of activities](#get-a-list-of-activities)
  - [Analytics](#analytics)
    - [Activity data by date](#activity-data-by-date)
    - [Opens by country](#opens-by-country)
    - [Opens by user-agent name](#opens-by-user-agent-name)
    - [Opens by reading environment](#opens-by-reading-environment)
  - [Inbound Routes](#inbound-routes)
    - [Get a list of inbound routes](#get-a-list-of-inbound-routes)
    - [Get a single inbound route](#get-a-single-inbound-route)
    - [Add an inbound route](#add-an-inbound-route)
    - [Update an inbound route](#update-an-inbound-route)
    - [Delete an inbound route](#delete-an-inbound-route)
  - [Domains](#domains)
    - [Get a list of domains](#get-a-list-of-domains)
    - [Get a single domain](#get-a-single-domain)
    - [Add a domain](#add-a-domain)
    - [Delete a domain](#delete-a-domain)
    - [Get recipients for a domain](#get-recipients-for-a-domain)
    - [Update domain settings](#update-domain-settings)
    - [Get DNS Records](#get-dns-records)
    - [Get verification status](#get-verification-status)
  - [Sender Identities](#sender-identities)
    - [Get a list of sender identities](#get-a-list-of-sender-identities)
    - [Get a single sender identity](#get-a-single-sender-identity)
    - [Get a single sender identity by email](#get-a-single-sender-identity-by-email)
    - [Add a sender identity](#add-a-sender-identity)
    - [Update a sender identity](#update-a-sender-identity)
    - [Update a sender identity by email](#update-a-sender-identity-by-email)
    - [Delete a sender identity](#delete-a-sender-identity)
    - [Delete a sender identity by email](#delete-a-sender-identity-by-email)
  - [Messages](#messages)
    - [Get a list of messages](#get-a-list-of-messages)
    - [Get info for a single message](#get-info-for-a-single-message)
  - [Scheduled Messages](#scheduled-messages)
    - [Get a list of scheduled messages](#get-a-list-of-scheduled-messages)
    - [Get a single scheduled message](#get-a-single-scheduled-message)
    - [Delete a scheduled message](#delete-a-scheduled-message)
  - [Recipients](#recipients)
    - [Get recipients](#get-recipients)
    - [Get a single recipient](#get-a-single-recipient)
    - [Delete a recipient](#delete-a-recipient)
  - [Suppressions](#suppressions)
    - [Get recipients from a suppression list](#get-recipients-from-a-suppression-list)
    - [Add recipients to a suppression list](#add-recipients-to-a-suppression-list)
    - [Delete recipients from a suppression list](#delete-recipients-from-a-suppression-list)
  - [Webhooks](#webhooks)
    - [List webhooks](#list-webhooks)
    - [Get a webhook](#get-a-webhook)
    - [Create a webhook](#create-a-webhook)
    - [Update a webhook](#update-a-webhook)
    - [Delete a webhook](#delete-a-webhook)
  - [Templates](#templates)
    - [Get templates](#get-templates)
    - [Get a single template](#get-a-single-template)
    - [Delete template](#delete-template)
  - [Email Verification](#email-verification)
    - [Verify an email](#verify-an-email)
    - [Get all email verification lists](#get-all-email-verification-lists)
    - [Get an email verification list](#get-an-email-verification-list)
    - [Create an email verification list](#create-an-email-verification-list)
    - [Verify an email list](#verify-an-email-list)
    - [Get email verification list results](#get-email-verification-list-results)
  - [SMS](#sms)
  - [SMS Messages](#sms-messages)
    - [Get a list of SMS messages](#get-a-list-of-sms-messages)
    - [Get info on an SMS message](#get-info-on-an-sms-message)
  - [SMS Activity](#sms-activity)
    - [Get a list of sms activities](#get-a-list-of-sms-activities)
  - [SMS Phone Numbers](#sms-phone-numbers)
    - [Get a list of SMS phone numbers](#get-a-list-of-sms-phone-numbers)
    - [Get an SMS phone number](#get-an-sms-phone-number)
    - [Update a single SMS phone number](#update-a-single-sms-phone-number)
    - [Delete an SMS phone number](#delete-an-sms-phone-number)
  - [SMS Recipients](#sms-recipients)
    - [Get a list of SMS recipients](#get-a-list-of-sms-recipients)
    - [Get an SMS recipient](#get-an-sms-recipient)
    - [Update a single SMS recipient](#update-a-single-sms-recipient)
  - [SMS Inbounds](#sms-inbounds)
    - [Get a list of SMS inbound routes](#get-a-list-of-sms-inbound-routes)
    - [Get a single SMS inbound route](#get-a-single-sms-inbound-route)
    - [Create an SMS inbound route](#create-an-sms-inbound-route)
    - [Update an SMS inbound route](#update-an-sms-inbound-route)
    - [Delete an SMS inbound route](#delete-an-sms-inbound-route)
  - [SMS Webhooks](#sms-webhooks)
    - [Get a list of SMS webhooks](#get-a-list-of-sms-webhooks)
    - [Get an SMS webhook](#get-an-sms-webhook)
    - [Create an SMS webhook](#create-an-sms-webhook)
    - [Update an SMS webhook](#update-an-sms-webhook)
    - [Delete an SMS webhook](#delete-an-sms-webhook)
  - [Other endpoints](#other-endpoints)
    - [Get API quota](#get-api-quota)
- [Support and Feedback](#support-and-feedback)
- [License](#license)

# Installation

## Setup

```bash
gem install mailersend-ruby
```

You will have to initalize it in your Ruby file with `require "mailersend-ruby"`.

## Email

### Send an email

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the email class
ms_email = Mailersend::Email.new(ms_client)

# Add parameters
ms_email.add_recipients("email" => "ron@parksandrec.com", "name" => "Ron")
ms_email.add_recipients("email" => "leslie@parksandrec.com", "name" => "Leslie")
ms_email.add_from("email" => "april@parksandrec.com", "name" => "April")
ms_email.add_subject("Time")
ms_email.add_text("Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.")
ms_email.add_html("<b>Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.</b>")

# Send the email
ms_email.send
```

### Add CC, BCC recipients

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the email class
ms_email = Mailersend::Email.new(ms_client)

# Add parameters
ms_email.add_recipients("email" => "ron@parksandrec.com", "name" => "Ron")
ms_email.add_recipients("email" => "leslie@parksandrec.com", "name" => "Leslie")
ms_email.add_cc("email" => "chris@parksandrec.com", "name" => "Chris")
ms_email.add_bcc("email" => "andy@parksandrec.com", "name" => "Andy")
ms_email.add_from("email" => "april@parksandrec.com", "name" => "April")
ms_email.add_subject("Time")
ms_email.add_text("Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.")
ms_email.add_html("<b>Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.</b>")

# Send the email
ms_email.send
```

### Send a template-based email

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the email class
ms_email = Mailersend::Email.new(ms_client)

# Add parameters
ms_email.add_recipients("email" => "ron@parksandrec.com", "name" => "Ron")
ms_email.add_recipients("email" => "leslie@parksandrec.com", "name" => "Leslie")
ms_email.add_from("email" => "april@parksandrec.com", "name" => "April")
ms_email.add_subject("Time")
ms_email.add_template_id(12415125)

# Send the email
ms_email.send
```

### Personalization

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the email class
ms_email = Mailersend::Email.new(ms_client)

# Add parameters
ms_email.add_recipients("email" => "ron@parksandrec.com", "name" => "Ron")
ms_email.add_from("email" => "april@parksandrec.com", "name" => "April")
ms_email.add_subject("Time {{ test }}")
ms_email.add_text("{{ test }}Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.")
ms_email.add_html("<b>{{ test }}Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.</b>")

personalization = {
  email: 'ron@parksandrec.com',
  data: {
    test: 'Test Value'
  }
}

ms_email.add_personalization(personalization)

ms_email.send
```

## Bulk Email

### Send bulk email
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_bulk_email = Mailersend::BulkEmail.new(ms_client)

ms_bulk_email.messages = [
    {
        'from' => {"email" => "april@parksandrec.com", "name" => "April"},
        'to' => [{"email" => "ron@parksandrec.com", "name" => "Ron"}],
        'subject' => "Time",
        'text' => "Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.",
        'html' => "<b>Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.</b>",
      },
      {
        'from' => {"email" => "april@parksandrec.com", "name" => "April"},
        'to' => [{"email" => "leslie@parksandrec.com", "name" => "Leslie"}],
        'subject' => "Lorem Ipsum",
        'text' => "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        'html' => "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>",
      }
]

ms_bulk_email.send
```

### Get bulk email status
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_bulk_email = Mailersend::BulkEmail.new(ms_client)
ms_bulk_email.get_bulk_status(bulk_email_id: 'yourbulkemailid')
```

## Tokens

### Create a token
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_tokens = Mailersend::Tokens.new(ms_client)
ms_tokens.create(name: "Very nice token", scopes: %w[ email_full domains_read ], domain_id: "yourdomainid")
```

### Update a token
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_tokens = Mailersend::Tokens.new(ms_client)
ms_tokens.update(token_id: "d2220fx04", status: "paused")
```

### Delete a token
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_tokens = Mailersend::Tokens.new(ms_client)
ms_tokens.delete(token_id: "d2220fx04")
```

### Send email with attachment

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the email class
ms_email = Mailersend::Email.new(ms_client)

# Add parameters
ms_email.add_recipients("email" => "ron@parksandrec.com", "name" => "Ron")
ms_email.add_recipients("email" => "leslie@parksandrec.com", "name" => "Leslie")
ms_email.add_cc("email" => "chris@parksandrec.com", "name" => "Chris")
ms_email.add_bcc("email" => "andy@parksandrec.com", "name" => "Andy")
ms_email.add_from("email" => "april@parksandrec.com", "name" => "April")
ms_email.add_subject("Time")
ms_email.add_text("Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.")
ms_email.add_html("<b>Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.</b>")

# You can add one or multiple attachments
ms.add_attachment(content: "/Users/Jerry/Desktop/doc.pdf", filename: "doc.pdf", disposition: "attachment")
ms.add_attachment(content: "/Users/Jerry/Desktop/pic.png", filename: "pic.png", disposition: "attachment")

ms_email.send
```

## Activity

### Get a list of activities

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_activity = Mailersend::Activity.new(ms_client)
ms_activity.get(domain_id: "xxx2241ll", page: 3, limit: 5, date_from: 1620643567, date_to: 1623321967)
```

## Analytics

### Activity data by date

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_analytics = Mailersend::Analytics.new(ms_client)
ms_analytics.date(date_from: 1620643567, date_to: 1623321967, events: %w[sent queued])
```

### Opens by country

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_analytics = Mailersend::Analytics.new(ms_client)
ms_analytics.country(date_from: 1620643567, date_to: 1623321967)
```

### Opens by user-agent name

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_analytics = Mailersend::Analytics.new(ms_client)
ms_analytics.ua_name(date_from: 1620643567, date_to: 1623321967)
```

### Opens by reading environment

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_analytics = Mailersend::Analytics.new(ms_client)
ms_analytics.ua_type(date_from: 1620643567, date_to: 1623321967)
```

## Inbound Routes

### Get a list of inbound routes

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_inbound_routes = Mailersend::InboundRouting.new(ms_client)
ms_inbound_routes.get_inbound_routes
```

### Get a single inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_inbound_routes = Mailersend::InboundRouting.new(ms_client)
ms_inbound_routes.get_single_route(inbound_id: 'idofroute12412')
```

### Add an inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_inbound_routes = Mailersend::InboundRouting.new(ms_client)
ms_inbound_routes.settings =
  {
    'domain_id' => 'yourdomainid',
    'name' => 'inbound_name',
    'domain_enabled' => false,
    'match_filter' => { 'type' => 'match_all' },
    'forwards' => [{ 'type' => 'webhook', 'value' => 'https://example.com' }]
  }
puts ms_inbound_routes.add_inbound_route
```

### Update an inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_inbound_routes = Mailersend::InboundRouting.new(ms_client)
ms_inbound_routes.settings =
  {
    'domain_id' => 'yourdomainid',
    'name' => 'inbound_updated',
    'domain_enabled' => false,
    'match_filter' => { 'type' => 'match_all' },
    'forwards' => [{ 'type' => 'webhook', 'value' => 'https://example.com' }]
  }
puts ms_inbound_routes.update_inbound_route(inbound_id: 'idofroute12412')
```

### Delete an inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_inbound_routes = Mailersend::InboundRouting.new(ms_client)
ms_inbound_routes.delete_route(inbound_id: 'idofroute12412')
```

## Domains

### Get a list of domains

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.list
```

### Get a single domain

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.single(domain_id: "idofdomain12412")
```

### Add a domain

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.add(name: 'yourdomain')
```

### Delete a domain

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.delete(domain_id: "idofdomain12412")
```

### Get recipients for a domain

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.recipients(domain_id: "idofdomain12412")
```

### Update domain settings

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.settings(domain_id: "idofdomain12412", track_clicks: true, track_unsubscribe: false)
```

### Get DNS Records

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.dns(domain_id: "idofdomain12412")
```

### Get verification status

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_domains = Mailersend::Domains.new(ms_client)
ms_domains.verify(domain_id: "idofdomain12412")
```

## Sender Identities

### Get a list of sender identities

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.list
```

### Get a single sender identity

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.single(identity_id: 'idofidentity123')
```

### Get a single sender identity by email

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.single_by_email(email: 'example@email.com')
```

### Add a sender identity

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.add(domain_id: 'idofdomain12412', name: 'yourname', email: 'youremail')
```

### Update a sender identity

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.update(identity_id: 'idofidentity123', reply_to_email: 'replyemail', reply_to_name: 'replyname')
```

### Update a sender identity by email

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.update_by_email(email: 'example@email.com', reply_to_email: 'replyemail', reply_to_name: 'replyname')
```

### Delete a sender identity

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.delete(identity_id: 'idofidentity123')
```

### Delete a sender identity by email

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_sender_identity = Mailersend::SenderIdentity.new(ms_client)
ms_sender_identity.delete_by_email(email: 'example@email.com')
```

## Messages

### Get a list of messages

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_messages = Mailersend::Messages.new(ms_client)
ms_messages.list(page: 1, limit: 10)
```

### Get info for a single message

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_messages = Mailersend::Messages.new(ms_client)
ms_messages.single(message_id: "mess11454")
```

## Scheduled Messages

### Get a list of scheduled messages

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_scheduled_messages = Mailersend::ScheduledMessages.new(ms_client)
ms_scheduled_messages.get_list
```

### Get a single scheduled message

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_scheduled_messages = Mailersend::ScheduledMessages.new(ms_client)
ms_scheduled_messages.get_single(message_id: 'mess11454')
```

### Delete a scheduled message

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_scheduled_messages = Mailersend::ScheduledMessages.new(ms_client)
ms_scheduled_messages.delete(message_id: 'mess11454')
```

## Recipients

### Get recipients

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_recipients = Mailersend::Recipients.new(ms_client)
ms_recipients.list(page: 1, limit: 10)
```

### Get a single recipient

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_recipients = Mailersend::Recipients.new(ms_client)
ms_recipients.single(recipient_id: "id124")
```

### Delete a recipient

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_recipients = Mailersend::Recipients.new(ms_client)
ms_recipients.delete(recipient_id: "id124")
```

## Suppressions

### Get recipients from a suppression list

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_suppressions = Mailersend::Suppressions.new(ms_client)

// List from Blocklist 
ms_suppressions.get_from_blocklist(domain_id: "xxx2241ll")

// List from Hard Bounces
ms_suppressions.get_hard_bounces(domain_id: "xxx2241ll")

// List from Spam Complaints
ms_suppressions.get_spam_complaints(domain_id: "xxx2241ll")

// List from Unsubscribers
ms_suppressions.get_unsubscribes(domain_id: "xxx2241ll")
```

### Add recipients to a suppression list

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_suppressions = Mailersend::Suppressions.new(ms_client)

// Add Recipient to Block List using recipients
ms_suppressions.add_to_blocklist(domain_id: "xxx2241ll", recipients: ["blocked@client.com"])

// Add Recipient to Block List using patterns
ms_suppressions.add_to_blocklist(domain_id: "xxx2241ll", patterns: ["*@client.com"])

// Add Recipient to Hard Bounces
ms_suppressions.add_to_hard_bounces(domain_id: "xxx2241ll", recipients: ["bounced@client.com"])

// Add Recipient to Spam Complaints
ms_suppressions.add_to_spam_complaints(domain_id: "xxx2241ll", recipients: ["bounced@client.com"])

// Add Recipient to Unsubscribes
ms_suppressions.add_to_unsubscribers(domain_id: "xxx2241ll", recipients: ["bounced@client.com"])
```

### Delete recipients from a suppression list

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_suppressions = Mailersend::Suppressions.new(ms_client)

// Delete from Block List
ms_suppressions.delete_from_blocklist(domain_id: 'yourdomainid', ids: ["xxx2241ll"])

// Delete from Hard Bounces
ms_suppressions.delete_from_hard_bounces(domain_id: 'yourdomainid', ids: ["xxx2241ll"])

// Delete from Spam Complaints
ms_suppressions.delete_from_spam_complaints(domain_id: 'yourdomainid', ids: ["xxx2241ll"])

// Delete from Unsubscribes
ms_suppressions.delete_from_unsubscribers(domain_id: 'yourdomainid', ids: ["xxx2241ll"])
```

## Webhooks

### List webhooks
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_webhooks = Mailersend::Webhooks.new(ms_client)
ms_webhooks.list(domain_id: "xxx2241ll")
```

### Get a webhook
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_webhooks = Mailersend::Webhooks.new(ms_client)
ms_webhooks.single(webhook_id: "zzz2241ll")
```

### Create a webhook
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_webhooks = Mailersend::Webhooks.new(ms_client)
ms_webhooks.create(domain_id: "xxx2241ll", url: "https://domain.com/hook", name: "Webhook", events: ["activity.sent", "activity.delivered"], enabled: true)
```

### Update a webhook
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_webhooks = Mailersend::Webhooks.new(ms_client)
ms_webhooks.update(webhook_id: "zzz2241ll", enabled: false)
```

### Delete a webhook
```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_webhooks = Mailersend::Webhooks.new(ms_client)
ms_webhooks.delete(webhook_id: "zzz2241ll")
```

## Templates

### Get templates

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_templates = Mailersend::Templates.new(ms_client)
ms_templates.list(domain_id: "aax455lll", page: 1, limit: 10)
```

### Get a single template

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_templates = Mailersend::Templates.new(ms_client)
ms_templates.single(template_id: "id124")
```

### Delete template

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_templates = Mailersend::Templates.new(ms_client)
ms_templates.delete(template_id: "id124")
```

## Email Verification

### Verify an email

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_email_verification = Mailersend::EmailVerification.new(ms_client)
ms_email_verification.verify_an_email(email: 'example@email.com')
```

### Get all email verification lists

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_email_verification = Mailersend::EmailVerification.new(ms_client)
ms_email_verification.list(page: 1, limit: 10)
```

### Get an email verification list

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_email_verification = Mailersend::EmailVerification.new(ms_client)
ms_email_verification.get_single_list(email_verification_id: 'your-email-verification-id')
```

### Create an email verification list

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_email_verification = Mailersend::EmailVerification.new(ms_client)
ms_email_verification.create_a_list(name: "name-your-list", emails: ["example@email.com"])
```

### Verify an email list

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_email_verification = Mailersend::EmailVerification.new(ms_client)
ms_email_verification.verify_a_list(email_verification_id: 'your-email-verification-id')
```

### Get email verification list results

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

ms_email_verification = Mailersend::EmailVerification.new(ms_client)
ms_email_verification.get_list_results(email_verification_id: 'your-email-verification-id')
```

## SMS 

### Send an SMS

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS class
ms_sms = Mailersend::SMS.new(ms_client)

# Add parameters
ms_sms.add_from('your-number')
ms_sms.add_to('client-number')
ms_sms.add_text('This is the message content')
personalization = {
  phone_number: 'client-number',
  data: {
    test: 'Test Value'
  }
}
ms_sms.add_personalization(personalization)

# Send the SMS
ms_sms.send
```

## SMS Messages

### Get a list of SMS messages

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Messages class
ms_sms_messages = Mailersend::SMSMessages.new(ms_client)

# Add parameters
ms_sms_messages.list(page: 1, limit: 10)
```

### Get info on an SMS message

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Messages class
ms_sms_messages = Mailersend::SMSMessages.new(ms_client)

# Add parameters
ms_sms_messages.get_single_route(sms_message_id: 'your-sms-message-id')
```

## SMS Activity

### Get a list of sms activities

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_activity = Mailersend::SMSActivity.new(ms_client)

# Add parameters
ms_sms_activity.list(page: 1, limit: 10)
```

## SMS phone numbers

### Get a list of SMS phone numbers

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_number = Mailersend::SMSNumber.new(ms_client)

# Add parameters
ms_sms_number.list(page: 1, limit: 10)
```

### Get an SMS phone number

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_number = Mailersend::SMSNumber.new(ms_client)

# Add parameters
ms_sms_number.get(sms_number_id: 'your-sms-number-id')
```

### Update a single SMS phone number

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_number = Mailersend::SMSNumber.new(ms_client)

# Add parameters
ms_sms_number.update(sms_number_id: 'your-sms-number-id', paused: false)
```

### Delete an SMS phone number

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_number = Mailersend::SMSNumber.new(ms_client)

# Add parameters
ms_sms_number.delete(sms_number_id: 'your-sms-number-id')
```

## SMS recipients

### Get a list of SMS recipients

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_recipient = Mailersend::SMSRecipient.new(ms_client)

# Add parameters
ms_sms_recipient.list(page: 1, limit: 10)
```

### Get an SMS recipient

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_recipient = Mailersend::SMSRecipient.new(ms_client)

# Add parameters
ms_sms_recipient.get(sms_recipient_id: 'your-sms-recipient-id')
```

### Update a single SMS recipient

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Recipient class
ms_sms_recipient = Mailersend::SMSRecipient.new(ms_client)

# Add parameters
ms_sms_recipient.update(sms_recipient_id: 'your-sms-recipient-id', status: 'opt_out')
```

## SMS Inbounds

### Get a list of SMS inbound routes

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Inbounds class
ms_sms_inbounds = Mailersend::SMSInbounds.new(ms_client)

ms_sms_inbounds.list
```

### Get a single SMS inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Inbounds class
ms_sms_inbounds = Mailersend::SMSInbounds.new(ms_client)

# Add parameters
ms_sms_inbounds.get_sms_inbound_route(sms_inbound_id: 'your-sms-inbound-id')
```

### Create an SMS inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Inbounds class
ms_sms_inbounds = Mailersend::SMSInbounds.new(ms_client)

# Add parameters
ms_sms_inbounds.settings =
  {
    'forward_url' => 'https://your-forward-url',
    'name' => 'name',
    'events' => ['sms.sent', 'sms.delivered'],
    'sms_number_id' => 'your-sms-number-id'
  }
puts ms_sms_inbounds.add_sms_inbound_route
```

### Update an SMS inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Inbounds class
ms_sms_inbounds = Mailersend::SMSInbounds.new(ms_client)

# Add parameters
ms_sms_inbounds.settings =
  {
    'forward_url' => 'https://your-forward-url',
    'name' => 'name',
    'events' => ['sms.sent', 'sms.delivered'],
    'sms_number_id' => 'your-sms-number-id'
  }
puts ms_sms_inbounds.update_sms_inbound_route(sms_inbound_id: 'your-sms-inbound-id')
```

### Delete an SMS inbound route

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Inbounds class
ms_sms_inbounds = Mailersend::SMSInbounds.new(ms_client)

# Add parameters
ms_sms_inbounds.delete_sms_inbound_route(sms_inbound_id: 'your-sms-inbound-id')
```

## SMS Webhooks

### Get a list of SMS webhooks

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Webhooks class
ms_sms_webhooks = Mailersend::SMSWebhooks.new(ms_client)

# Add parameters
ms_sms_webhooks.list(sms_number_id: 'your-sms-number-id')
```

### Get an SMS webhook

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Webhooks class
ms_sms_webhooks = Mailersend::SMSWebhooks.new(ms_client)

# Add parameters
ms_sms_webhooks.get_sms_webhook_route(sms_webhook_id: 'your-sms-webhook-id')
```

### Create an SMS webhook

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Webhooks class
ms_sms_webhooks = Mailersend::SMSWebhooks.new(ms_client)

# Add parameters
ms_sms_webhooks.settings =
  {
    'sms_number_id' => 'your-sms-number-id',
    'name' => 'your-name',
    'url' => 'https://your-url.com',
    'events' => ['sms.sent', 'sms.delivered']
  }
puts ms_sms_webhooks.add_sms_webhook_route
```

### Update an SMS webhook

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Webhooks class
ms_sms_webhooks = Mailersend::SMSWebhooks.new(ms_client)

# Add parameters
ms_sms_webhooks.settings =
  {
    'sms_number_id' => 'your-sms-number-id',
    'name' => 'your-name',
    'url' => 'https://your-url.com',
    'events' => ['sms.sent', 'sms.delivered']
  }
puts ms_sms_webhooks.update_sms_webhook_route(sms_webhook_id: 'your-sms-webhook-id')
```

### Delete an SMS webhook

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the SMS Webhooks class
ms_sms_webhooks = Mailersend::SMSWebhooks.new(ms_client)

# Add parameters
ms_sms_webhooks.delete_sms_webhook_route(sms_webhook_id: 'your-sms-webhook-id')
```

## Other endpoints

### Get API quota

```ruby
require "mailersend-ruby"

ms_client = Mailersend::Client.new('your_mailersend_token')

# Intialize the API Quota class
ms_api_quota = Mailersend::APIQuota.new(ms_client)

# Add parameters
ms_api_quota.get_api_quota
```
# Testing

```bash
bundle i
bundle exec rspec spec/*_rspec.rb
```

To run tests you would need to install gems using bundle and then run rspec via bundle to run all tests.
The fixtures for the test have been recorded using vcr and are available in the ./fixtures directory.

# Support and Feedback

In case you find any bugs, submit an issue directly here in GitHub.

You are welcome to create SDK for any other programming language.

If you have any troubles using our API or SDK free to contact our support by email [info@mailersend.com](mailto:info@mailersend.com)

The official documentation is at [https://developers.mailersend.com](https://developers.mailersend.com)

# License

[The MIT License (MIT)](LICENSE)
