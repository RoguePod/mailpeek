require_dependency 'mailpeek/application_controller'

module Mailpeek
  # Public: MailController
  class MailController < ApplicationController
    before_action :load_emails

    def index
      @emails = @emails.sort.reverse.to_h
    end

    def destroy
      email = @emails[params[:id]]

      File.delete("#{directory}/#{params[:id]}") if email

      head :ok
    end

    def destroy_all
      @emails.each do |file, _|
        File.delete("#{directory}/#{file}")
      end

      head :ok
    end

    private

    def load_emails
      @emails = {}
      return unless File.directory?(directory)

      Dir.foreach(directory) do |filename|
        next if filename == '.' || filename == '..'
        @emails[filename] = Mail.read("#{directory}/#{filename}")
      end
    end

    def directory
      Rails.root.join('tmp', 'mailpeek')
    end
  end
end
