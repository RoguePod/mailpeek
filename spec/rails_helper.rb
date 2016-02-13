ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
# require 'jbuilder'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'lib'
end

RSpec.configure do |config|
  # config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.render_views = true

  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.filter_rails_from_backtrace!

  config.after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
