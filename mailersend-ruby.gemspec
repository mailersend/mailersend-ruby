# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailersend/version'

Gem::Specification.new do |spec|
  spec.name          = 'mailersend-ruby'
  spec.version       = Mailersend::VERSION
  spec.authors       = ['Nikola Milojević']
  spec.email         = ['info@mailersend.com']

  spec.summary       = "MailerSend's official Ruby SDK"
  spec.description   = "MailerSend's official Ruby SDK. Interacts with all endpoints at MailerSend API."
  spec.homepage      = 'https://www.mailersend.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mailersend/mailersend-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/mailersend/mailersend-ruby/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'http', '~> 5.0'
  spec.add_dependency 'json', '~> 2.5'
  spec.add_dependency 'uri', '~> 0.12.2'
end
