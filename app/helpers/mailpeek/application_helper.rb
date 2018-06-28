# frozen_string_literal: true

module Mailpeek
  # Public: ApplicationHelper
  module ApplicationHelper
    def unread
      @unread ||= Mailpeek.unread
    end
  end
end
