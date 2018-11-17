# frozen_string_literal: true

Mailpeek.configure do |config|
  config.location = Rails.root.join('..', 'support', 'emails')
end
