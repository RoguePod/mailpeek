# frozen_string_literal: true

require 'mail'
require 'mailpeek/email'
require 'mailpeek/delivery'
require 'mailpeek/configuration'
require 'mailpeek/web'

require 'json'

# Public: Mailpeek
module Mailpeek
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.emails
    emails   = []
    location = Mailpeek.configuration.location

    prep_folder

    Dir.foreach(location) do |filename|
      next if ['.', '..'].include?(filename)

      path  = File.join(location, filename, 'mail')
      email = Email.new(filename, ::Mail.read(path))

      emails.push(email)
    end

    emails.sort_by(&:position).reverse
  end

  def self.email(timestamp)
    emails.detect { |x| x.id == timestamp }
  end

  def self.unread
    unread   = 0
    location = Mailpeek.configuration.location

    prep_folder

    Dir.foreach(location) do |filename|
      next if ['.', '..'].include?(filename)

      unread += 1 unless File.exist?(File.join(location, filename, '.read'))
    end

    unread
  end

  def self.prep_folder
    location = Mailpeek.configuration.location

    FileUtils.mkdir_p(location) unless File.directory?(location)
  end
end

require 'mailpeek/railtie' if defined?(Rails::Railtie)
