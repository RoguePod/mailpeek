# frozen_string_literal: true

require_dependency 'mailpeek/application_controller'

module Mailpeek
  # Public: Actions for Emails
  class EmailsController < ApplicationController
    def index
      respond_to do |format|
        format.json do
          @emails = emails
        end

        format.html do
          email = emails.first

          return if email.blank?

          redirect_to(
            action: :show, id: email.id, params: request.query_parameters
          )
        end
      end
    end

    def show
      @emails = Mailpeek.emails

      if params[:q].present?
        @emails = @emails.select { |x| x.match?(params[:q]) }
      end

      @emails = Kaminari.paginate_array(@emails).page(1).per(params[:per])
      @email  = @emails.detect { |x| x.id.to_s == params[:id].to_s }

      if @email.blank?
        redirect_to action: :index, params: request.query_parameters
      else
        @email.read = true
      end
    end

    def read
      Mailpeek.emails.each do |email|
        email.read = true
      end

      if params[:email_id].present?
        redirect_to email_path(params[:email_id])
      else
        redirect_to root_path
      end
    end

    def destroy
      email = Mailpeek.email(params[:id])

      email&.destroy

      redirect_to action: :index, params: request.query_parameters
    end

    def destroy_all
      Mailpeek.emails.each(&:destroy)

      redirect_to root_path
    end

    private

    def emails
      return @emails if @emails

      @emails = Mailpeek.emails

      if params[:q].present?
        @emails = @emails.select { |x| x.match?(params[:q]) }
      end

      @emails = Kaminari.paginate_array(emails).page(1).per(params[:per])
    end
  end
end
