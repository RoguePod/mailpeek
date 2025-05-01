# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'mailpeek/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'mailpeek'
  s.version     = Mailpeek::VERSION
  s.authors     = ['Rogue Pod, LLC.']
  s.email       = ['support@roguepod.com']
  s.homepage    = 'https://github.com/RoguePod/mailpeek'
  s.summary     = 'View Emails in Rails'
  s.description = 'A web interface to view emails sent out when ' \
    'developing in Rails'
  s.license     = 'MIT'

  s.files = `git ls-files`.split("\n")

  s.test_files = Dir['spec/**/*']

  s.required_ruby_version = '>= 3.0.0'

  s.add_dependency 'mail', '~> 2'
  s.add_dependency 'rack', '~> 3'
  s.add_dependency 'rack-protection', '~> 4'

  s.add_development_dependency 'faker'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-performance'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'simplecov'
end
