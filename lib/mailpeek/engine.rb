# frozen_string_literal: true

module Mailpeek
  # Public: Engine
  class Engine < ::Rails::Engine
    isolate_namespace Mailpeek

    initializer 'mailpeek.add_delivery_method' do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(
          :mailpeek,
          Mailpeek::Delivery
        )
      end
    end

    require 'jbuilder'
    require 'kaminari'
  end
end
