# frozen_string_literal: true

module Mailpeek
  # Public: Stores config info for Mailpeek
  class Configuration
    attr_accessor :location, :limit

    def initialize
      @location = Dir.mktmpdir('mailpeek')
      @limit = 50
    end
  end
end
