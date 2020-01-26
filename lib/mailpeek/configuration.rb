# frozen_string_literal: true

require 'mail/check_delivery_params'

module Mailpeek
  # Public: Stores config info for Mailpeek
  class Configuration
    attr_accessor :location, :limit

    def initialize
      @location = Rails.root.join('tmp', 'mailpeek')
      @limit = 50
    end
  end
end
