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
    - [Advanced personalization](#advanced-personalization)
    - [Simple personalization](#simple-personalization)
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
    - [Delete a domain](#delete-a-domain)
    - [Get recipients for a domain](#get-recipients-for-a-domain)
    - [Update domain settings](#update-domain-settings)
    - [Get DNS Records](#get-dns-records)
    - [Get verification status](#get-verification-status)
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
- [Support and Feedback](#support-and-feedback)
- [License](#license)

# Installation

## Setup

```bash
gem install mailersend-ruby
```

You will have to initalize it in your Ruby file with `require "mailersend-ruby"`.

# Usage

This SDK requires that you either have `.env` file with `MAILERSEND_API_TOKEN` env variable or that your variable is enabled system wide (useful for Docker/Kubernetes). The example of how `MAILERSEND_API_TOKEN` should look like is in `.env.example`.

## Email

### Send an email

```ruby
require "mailersend-ruby"

# Intialize the email class
ms_email = Mailersend::Email.new

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

# Intialize the email class
ms_email = Mailersend::Email.new

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

# Intialize the email class
ms_email = Mailersend::Email.new

# Add parameters
ms_email.add_recipients("email" => "ron@parksandrec.com", "name" => "Ron")
ms_email.add_recipients("email" => "leslie@parksandrec.com", "name" => "Leslie")
ms_email.add_from("email" => "april@parksandrec.com", "name" => "April")
ms_email.add_subject("Time")
ms_email.add_template_id(12415125)

# Send the email
ms_email.send
```

### Advanced personalization

```ruby
require "mailersend-ruby"

# Intialize the email class
ms_email = Mailersend::Email.new

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

### Simple personalization

```ruby
require "mailersend-ruby"

# Intialize the email class
ms_email = Mailersend::Email.new

# Add parameters
ms_email.add_recipients("email" => "ron@parksandrec.com", "name" => "Ron")
ms_email.add_from("email" => "april@parksandrec.com", "name" => "April")
ms_email.add_subject("Time {$test}")
ms_email.add_text("{$test} Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.")
ms_email.add_html("<b>{$test} Time is money, money is power, power is pizza, and pizza is knowledge. Let's go.</b>")

variables = {
  email: 'ron@parksandrec.com',
  substitutions: [
    {
      var: 'test',
      value: 'Test Value'
    }
  ]
}

ms_email.add_variables(variables)

ms_email.send
```

## Bulk Email

### Send bulk email
```ruby
require "mailersend-ruby"

ms_bulk_email = Mailersend::BulkEmail.new

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

ms_bulk_email = Mailersend::BulkEmail.new
ms_bulk_email.get_bulk_status(bulk_email_id: 'yourbulkemailid')
```

## Tokens

### Create a token
```ruby
require "mailersend-ruby"

ms_tokens = Mailersend::Tokens.new
ms_tokens.create(name: "Very nice token", scopes: %w[ email_full domains_read ], domain_id: "yourdomainid")
```

### Update a token
```ruby
require "mailersend-ruby"

ms_tokens = Mailersend::Tokens.new
ms_tokens.update(token_id: "d2220fx04", status: "paused")
```

### Delete a token
```ruby
require "mailersend-ruby"

ms_tokens = Mailersend::Tokens.new
ms_tokens.delete(token_id: "d2220fx04")
```

### Send email with attachment

```ruby
require "mailersend-ruby"

# Intialize the email class
ms_email = Mailersend::Email.new

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
ms.add_attachment(content: "/Users/Jerry/Desktop/doc.pdf", filename: "doc.pdf")
ms.add_attachment(content: "/Users/Jerry/Desktop/pic.png", filename: "pic.png")

ms_email.send
```

## Activity

### Get a list of activities

```ruby
require "mailersend-ruby"

ms_activity = Mailersend::Activity.new
ms_activity.get(domain_id: "xxx2241ll", page: 3, limit: 5, date_from: 1620643567, date_to: 1623321967)
```

## Analytics

### Activity data by date

```ruby
require "mailersend-ruby"

ms_analytics = Mailersend::Analytics.new
ms_analytics.date(date_from: 1620643567, date_to: 1623321967, events: %w[sent queued])
```

### Opens by country

```ruby
require "mailersend-ruby"

ms_analytics = Mailersend::Analytics.new
ms_analytics.country(date_from: 1620643567, date_to: 1623321967)
```

### Opens by user-agent name

```ruby
require "mailersend-ruby"

ms_analytics = Mailersend::Analytics.new
ms_analytics.ua_name(date_from: 1620643567, date_to: 1623321967)
```

### Opens by reading environment

```ruby
require "mailersend-ruby"

ms_analytics = Mailersend::Analytics.new
ms_analytics.ua_type(date_from: 1620643567, date_to: 1623321967)
```

## Inbound Routes

### Get a list of inbound routes

```ruby
require "mailersend-ruby"

ms_inbound_routes = Mailersend::InboundRouting.new
ms_inbound_routes.get_inbound_routes
```

### Get a single inbound route

```ruby
require "mailersend-ruby"

ms_inbound_routes = Mailersend::InboundRouting.new
ms_inbound_routes.get_single_route(inbound_id: 'idofroute12412')
```

## Domains

### Get a list of domains

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.list
```

### Get a single domain

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.single(domain_id: "idofdomain12412")
```

### Delete a domain

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.delete(domain_id: "idofdomain12412")
```

### Get recipients for a domain

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.recipients(domain_id: "idofdomain12412")
```

### Update domain settings

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.settings(domain_id: "idofdomain12412", track_clicks: true, track_unsubscribe: false)
```

### Get DNS Records

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.dns(domain_id: "idofdomain12412")
```

### Get verification status

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.verify(domain_id: "idofdomain12412")
```

## Messages

### Get a list of messages

```ruby
require "mailersend-ruby"

ms_messages = Mailersend::Messages.new
ms_messages.list(page: 1, limit: 10)
```

### Get info for a single message

```ruby
require "mailersend-ruby"

ms_messages = Mailersend::Messages.new
ms_messages.single(message_id: "mess11454")
```

## Scheduled Messages

### Get a list of scheduled messages

```ruby
require "mailersend-ruby"

ms_scheduled_messages = Mailersend::ScheduledMessages.new
ms_scheduled_messages.get_list
```

### Get a single scheduled message

```ruby
require "mailersend-ruby"

ms_scheduled_messages = Mailersend::ScheduledMessages.new
ms_scheduled_messages.get_signle(message_id: 'mess11454')
```

### Delete a scheduled message

```ruby
require "mailersend-ruby"

ms_scheduled_messages = Mailersend::ScheduledMessages.new
ms_scheduled_messages.delete(message_id: 'mess11454')
```

## Recipients

### Get recipients

```ruby
require "mailersend-ruby"

ms_recipients = Mailersend::Recipients.new
ms_recipients.list(page: 1, limit: 10)
```

### Get a single recipient

```ruby
require "mailersend-ruby"

ms_recipients = Mailersend::Recipients.new
ms_recipients.single(recipient_id: "id124")
```

### Delete a recipient

```ruby
require "mailersend-ruby"

ms_recipients = Mailersend::Recipients.new
ms_recipients.delete(recipient_id: "id124")
```

## Suppressions

### Get recipients from a suppression list

```ruby
require "mailersend-ruby"

ms_suppressions = Mailersend::Suppressions.new

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

ms_suppressions = Mailersend::Suppressions.new

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

ms_suppressions = Mailersend::Suppressions.new

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

ms_webhooks = Mailersend::Webhooks.new
ms_webhooks.list(domain_id: "xxx2241ll")
```

### Get a webhook
```ruby
require "mailersend-ruby"

ms_webhooks = Mailersend::Webhooks.new
ms_webhooks.single(webhook_id: "zzz2241ll")
```

### Create a webhook
```ruby
require "mailersend-ruby"

ms_webhooks = Mailersend::Webhooks.new
ms_webhooks.create(domain_id: "xxx2241ll", url: "https://domain.com/hook", name: "Webhook", events: ["activity.sent", "activity.delivered"], enabled: true)
```

### Update a webhook
```ruby
require "mailersend-ruby"

ms_webhooks = Mailersend::Webhooks.new
ms_webhooks.update(webhook_id: "zzz2241ll", enabled: false)
```

### Delete a webhook
```ruby
require "mailersend-ruby"

ms_webhooks = Mailersend::Webhooks.new
ms_webhooks.delete(webhook_id: "zzz2241ll")
```

## Templates

### Get templates

```ruby
require "mailersend-ruby"

ms_templates = Mailersend::Templates.new
ms_templates.list(domain_id: "aax455lll", page: 1, limit: 10)
```

### Get a single template

```ruby
require "mailersend-ruby"

ms_templates = Mailersend::Templates.new
ms_templates.single(template_id: "id124")
```

### Delete template

```ruby
require "mailersend-ruby"

ms_templates = Mailersend::Templates.new
ms_templates.delete(template_id: "id124")
```

# Support and Feedback

In case you find any bugs, submit an issue directly here in GitHub.

You are welcome to create SDK for any other programming language.

If you have any troubles using our API or SDK free to contact our support by email [info@mailersend.com](mailto:info@mailersend.com)

The official documentation is at [https://developers.mailersend.com](https://developers.mailersend.com)

# License

[The MIT License (MIT)](LICENSE)
