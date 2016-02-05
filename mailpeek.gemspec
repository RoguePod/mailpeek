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
  s.description = 'Provides an rails routes to view sent email'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '4.2.5.1'
  s.add_dependency 'mail'
  s.add_dependency 'jbuilder'
  s.add_dependency 'react-rails'
  s.add_dependency 'uglifier'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'font-awesome-sass'
  s.add_dependency 'lodash-rails'
  s.add_dependency 'momentjs-rails'

  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'rspec-rails'
end
