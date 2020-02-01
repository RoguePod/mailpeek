# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  # add_group 'Group', 'lib/mailpeek'
end

require 'mailpeek'
require 'faker'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.before do
    Mailpeek.configure do |c|
      c.location = File.dirname(__FILE__) + '/support/emails'
    end
  end
end
