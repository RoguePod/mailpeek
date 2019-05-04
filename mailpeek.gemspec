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

  s.add_dependency 'autoprefixer-rails', '>= 9.3.1'
  s.add_dependency 'jbuilder', '>= 2.8.0'
  s.add_dependency 'jquery-rails', '>= 4.3.3'
  s.add_dependency 'kaminari', '>= 1.1.1'
  s.add_dependency 'mail', '>= 2.7.1'
  s.add_dependency 'rails', '>= 4.0'
  s.add_dependency 'slim-rails', '>= 3.2.0'
  s.add_dependency 'turbolinks', '>= 4.0'

  s.add_development_dependency 'guard-rubocop', '>= 1.3.0'
  s.add_development_dependency 'rails-controller-testing', '>= 1.0.2'
  s.add_development_dependency 'rspec-rails', '>= 3.8.1'
  s.add_development_dependency 'rubocop-performance', '>= 0'
  s.add_development_dependency 'rubocop-rspec', '>= 1.30.1'
  s.add_development_dependency 'simplecov', '>= 0.16.1'
end
