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
  - [Tokens](#tokens)
    - [Create a token](#create-a-token)
    - [Update a token](#update-a-token)
    - [Delete a token](#delete-a-token)
    - [Advanced personalization](#advanced-personalization)
    - [Simple personalization](#simple-personalization)
    - [Send email with attachment](#send-email-with-attachment)
  - [Activity](#activity)
    - [Get a list of activities](#get-a-list-of-activities)
  - [Analytics](#analytics)
    - [Activity data by date](#activity-data-by-date)
    - [Opens by country](#opens-by-country)
    - [Opens by user-agent name](#opens-by-user-agent-name)
    - [Opens by reading environment](#opens-by-reading-environment)
  - [Domains](#domains)
    - [Get a list of domains](#get-a-list-of-domains)
    - [Get a single domain](#get-a-single-domain)
    - [Delete a domain](#delete-a-domain)
    - [Update domain settings](#update-domain-settings)
  - [Messages](#messages)
    - [Get a list of messages](#get-a-list-of-messages)
    - [Get info for a single message](#get-info-for-a-single-message)
  - [Recipients](#recipients)
    - [Get recipients](#get-recipients)
    - [Get a single recipient](#get-a-single-recipient)
    - [Delete a recipient](#delete-a-recipient)
  - [Webhooks](#webhooks)
    - [List webhooks](#list-webhooks)
    - [Get a webhook](#get-a-webhook)
    - [Create a webhook](#create-a-webhook)
    - [Update a webhook](#update-a-webhook)
- [Support and Feedback](#support-and-feedback)
- [License](#license)

# Installation

## Setup

```bash
gem install mailersend-ruby
```

You will have to initalize it in your Ruby file with `require "mailersend-ruby"`.

# Usage

This SDK requires that you either have `.env` file with `API_TOKEN` env variable or that your variable is enabled system wide (useful for Docker/Kubernetes). The example of how `API_TOKEN` should look like is in `.env.example`.

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

## Tokens

### Create a token
```ruby
require "mailersend-ruby"

ms_tokens = Mailersend::Tokens.new
ms_tokens.create(name: "Very nice token", scopes: %w[ email_full domains_read ])
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
ms_domains.list(domain_id: "idofdomain12412")
```

### Delete a domain

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.delete(domain_id: "idofdomain12412")
```

### Update domain settings

```ruby
require "mailersend-ruby"

ms_domains = Mailersend::Domains.new
ms_domains.settings(domain_id: "idofdomain12412", track_clicks: true, track_unsubscribe: false)
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
ms_webhooks.list(webhook_id: "zzz2241ll")
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

# Support and Feedback

In case you find any bugs, submit an issue directly here in GitHub.

You are welcome to create SDK for any other programming language.

If you have any troubles using our API or SDK free to contact our support by email [info@mailersend.com](mailto:info@mailersend.com)

The official documentation is at [https://developers.mailersend.com](https://developers.mailersend.com)

# License

[The MIT License (MIT)](LICENSE)
