# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('dummy/config/environment.rb', __dir__)
require 'rspec/rails'
require 'rails-controller-testing'
# require 'jbuilder'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'lib'
end

RSpec.configure do |config|
  # config.mock_with :rspec
  %i[controller view request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end

  config.use_transactional_fixtures = false
  config.render_views = true

  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.filter_rails_from_backtrace!

  config.after do
    ActionMailer::Base.deliveries.clear
  end
end
