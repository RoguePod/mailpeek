# frozen_string_literal: true

require 'mail/check_delivery_params'

module Mailpeek
  class Configuration
    attr_accessor :location, :limit

    def initialize
      @location = Rails.root.join('tmp', 'mailpeek')
      @limit    = 25
    end
  end
end
