require_dependency 'mailpeek/application_controller'

module Mailpeek
  # Public: MailController
  class MailController < ApplicationController
    def index
      # raise 'nope'
      dir     = Rails.root.join('tmp', 'mailpeek')
      @emails = []

      return unless File.directory?(dir)

      Dir.foreach(dir) do |item|
        next if item == '.' || item == '..'
        mail = Mail.read("#{dir}/#{item}")
        # puts mail.inspect
        @emails.push mail
      end

      @emails = @emails.sort { |a, b| b.date <=> a.date }.first(50)
    end
  end
end
