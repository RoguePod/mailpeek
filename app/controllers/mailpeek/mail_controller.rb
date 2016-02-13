require_dependency 'mailpeek/application_controller'

module Mailpeek
  # Public: MailController
  class MailController < ApplicationController
    def index
      dir     = Rails.root.join('tmp', 'mailpeek')
      @emails = []

      return unless File.directory?(dir)

      Dir.foreach(dir) do |item|
        next if item == '.' || item == '..'
        mail = Mail.read("#{dir}/#{item}")
        @emails.push mail
      end

      @emails = @emails.sort { |a, b| b.date <=> a.date }.first(50)
    end

    def all
      dir     = Rails.root.join('tmp', 'mailpeek')
      @emails = []

      return unless File.directory?(dir)

      Dir.foreach(dir) do |item|
        next if item == '.' || item == '..'
        File.delete("#{dir}/#{item}")
      end

      head :ok
    end
  end
end
