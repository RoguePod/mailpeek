# frozen_string_literal: true

require 'mail'
require 'mailpeek/engine'
require 'mailpeek/email'
require 'mailpeek/delivery'
require 'mailpeek/configuration'

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
      next if filename == '.' || filename == '..'

      path  = File.join(location, filename, 'mail')
      email = Email.new(filename, ::Mail.read(path))

      emails.push(email)
    end

    emails.sort_by { |x| x.position }.reverse
  end

  def self.email(timestamp)
    emails.detect { |x| x.id == timestamp }
  end

  def self.unread
    unread   = 0
    location = Mailpeek.configuration.location

    prep_folder

    Dir.foreach(location) do |filename|
      next if filename == '.' || filename == '..'

      unread += 1 unless File.exists?(File.join(location, filename, '.read'))
    end

    unread
  end

  def self.prep_folder
    location = Mailpeek.configuration.location

    FileUtils.mkdir_p(location) unless File.directory?(location)
  end
end
