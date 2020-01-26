# frozen_string_literal: true

require 'mail/check_delivery_params'

module Mailpeek
  # Public: Wrapper class for mail object
  class Email
    attr_reader(
      :id, :position, :mail, :html, :text, :attachments, :to, :from, :subject,
      :message_id, :date
    )

    def initialize(timestamp, mail)
      @id          = timestamp
      @position    = timestamp
      @mail        = mail
      @to          = mail[:to].addrs.map(&:format)
      @from        = mail[:from].addrs.map(&:format)
      @subject     = mail.subject
      @message_id  = mail.message_id
      @date        = mail.date
      @attachments = []

      if mail.multipart?
        parse_parts
      else
        parse_body
      end
    end

    def match?(query)
      subject&.match(query) || text&.match(query) || html&.match(query)
    end

    def destroy
      location = Mailpeek.configuration.location

      FileUtils.rm_rf("#{location}/#{id}")
    end

    def read
      File.exist?(read_file_path)
    end

    def read=(value)
      if value && !read
        FileUtils.touch(read_file_path)
      elsif !value && read
        File.delete(read_file_path)
      end
    end

    private

    def read_file_path
      File.join(Mailpeek.configuration.location, id, '.read')
    end

    def parse_parts
      if mail.html_part
        @html = mail.html_part.body.decoded.force_encoding('utf-8')
      end

      if mail.text_part
        @text = mail.text_part.body.decoded.force_encoding('utf-8')
      end

      return unless mail.attachments.any?

      mail.attachments.each do |attachment|
        @attachments.push(attachment.filename.gsub(/[^\w\-_.]/, '_'))
      end
    end

    def parse_body
      body = mail.body.decoded.force_encoding('utf-8')

      if mail.content_type.match(/html/)
        @html = body
      else
        @text = body
      end
    end
  end
end
