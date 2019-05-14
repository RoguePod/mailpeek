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
  s.summary     = 'Preview Rails Emails'
  s.description = 'Provides a web interface to view emails sent out when ' \
    'developing in Rails'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc'
  ]

  s.test_files = Dir['spec/**/*']

  s.add_dependency 'mail', '~> 2.7.1'
  s.add_dependency 'rack', '~> 2.0.7'
  s.add_dependency 'rack-protection', '~> 2.0.5'

  s.add_development_dependency 'rubocop', '~> 0.69.0'
  s.add_development_dependency 'rubocop-performance', '~> 1.3.0'
end
