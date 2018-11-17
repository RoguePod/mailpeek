# frozen_string_literal: true

require 'mail/check_delivery_params'

module Mailpeek
  # Public: Delivery
  class Delivery
    include Mail::CheckDeliveryParams if defined?(Mail::CheckDeliveryParams)

    class InvalidOption < StandardError; end

    attr_accessor :settings

    # rubocop:disable Style/GuardClause
    def initialize(options = {})
      options[:location] ||= Mailpeek.configuration.location
      options[:limit] ||= Mailpeek.configuration.limit
      options[:limit] = options[:limit].to_i

      if options[:location].nil?
        raise InvalidOption, 'A location option is required when using Mailpeek'
      end

      if options[:limit].nil?
        raise InvalidOption, 'A limit option is required when using Mailpeek'
      elsif options[:limit] <= 0
        raise InvalidOption, 'A limit option is an invalid number'
      end

      self.settings = options
    end
    # rubocop:enable Style/GuardClause

    def deliver!(mail)
      check_delivery_params(mail) if respond_to?(:check_delivery_params)

      clean_up

      basepath = File.join(settings[:location], Time.now.to_i.to_s)

      save_email(mail, basepath)

      return true unless mail.attachments.any?

      add_attachments(mail, basepath)
    end

    private

    def clean_up
      # remove oldest email if over `limit` settings

      directory = File.join(settings[:location], '*')
      return if Dir[directory].length < settings[:limit]

      FileUtils.rm_rf(Dir[File.join(settings[:location], '*')].min)
    end

    def save_email(mail, basepath)
      FileUtils.mkdir_p(basepath)

      File.open(File.join(basepath, 'mail'), 'w') do |f|
        f.write mail.to_s
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
