# frozen_string_literal: true

module Mailpeek
  # Public: Railtie
  class Railtie < Rails::Railtie
    initializer 'mailpeek.add_delivery_method' do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(
          :mailpeek,
          Mailpeek::Delivery
        )
      end
    end
  end
end
