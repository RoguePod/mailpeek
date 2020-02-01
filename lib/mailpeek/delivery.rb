# frozen_string_literal: true

module Mailpeek
  # Public: Handles consuming emails, checking configuration, creating
  # directories, cleaning up emails and saving attachments
  class Delivery
    class InvalidOption < StandardError; end

    attr_accessor :settings

    def initialize(options = {})
      options[:location] ||= Mailpeek.configuration.location
      options[:limit] ||= Mailpeek.configuration.limit
      options[:limit] = options[:limit].to_i

      if options[:location].nil?
        raise InvalidOption, 'The Mailpeek location option is required'
      end

      if options[:limit] <= 0
        raise InvalidOption, 'The Mailpeek limit option is an invalid number'
      end

      self.settings = options
    end

    def deliver!(mail)
      clean_up

      timestamp = Time.now.to_i.to_s

      basepath = File.join(settings[:location], timestamp)

      save_email(mail, basepath)

      add_attachments(mail, basepath) if mail.attachments.any?

      timestamp
    end

    private

    # remove oldest email if over `limit` settings
    def clean_up
      directory = File.join(settings[:location], '*')
      return if Dir[directory].length < settings[:limit]

      FileUtils.rm_rf(Dir[File.join(settings[:location], '*')].min)
    end

    def save_email(mail, basepath)
      FileUtils.mkdir_p(basepath)

      File.open(File.join(basepath, 'mail'), 'w') do |file|
        file.write(mail.to_s)
      end
    end

    def add_attachments(mail, basepath)
      attachments_dir = File.join(basepath, 'attachments')
      FileUtils.mkdir_p(attachments_dir) unless File.directory?(attachments_dir)

      mail.attachments.each do |attachment|
        filename = attachment.filename.gsub(/[^\w\-_.]/, '_')
        path     = File.join(attachments_dir, filename)

        unless File.exist?(path)
          File.open(path, 'wb') { |f| f.write(attachment.body.raw_source) }
        end
      end
    end
  end
end
