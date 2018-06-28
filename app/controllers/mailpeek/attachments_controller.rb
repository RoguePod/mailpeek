# frozen_string_literal: true

require_dependency 'mailpeek/application_controller'

module Mailpeek
  # Public: Handle actions for email attachments
  class AttachmentsController < ApplicationController
    def show
      location = Mailpeek.configuration.location
      path     = File.join(
        location, params[:email_id], 'attachments',
        "#{params[:id]}.#{params[:format]}"
      )

      send_file path
    end
  end
end
