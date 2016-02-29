$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'mailpeek/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'mailpeek'
  s.version     = Mailpeek::VERSION
  s.authors     = ['Rogue Pod, LLC.']
  s.email       = ['jeffharper@roguepod.com']
  s.homepage    = 'https://github.com/RoguePod/mailpeek'
  s.summary     = 'Preview Rails Emails'
  s.description = 'Provides a web interface to view emails sent out when ' \
    'developing in Rails'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '>= 4'
  s.add_dependency 'jbuilder', '>= 2'

  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'rspec-rails', '>= 3'
  s.add_development_dependency 'simplecov'
end
