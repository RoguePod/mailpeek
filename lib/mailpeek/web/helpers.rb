# frozen_string_literal: true

require 'uri'
require 'set'
require 'yaml'
require 'cgi'

module Mailpeek
  # Private: WebHelpers
  module WebHelpers
    def emails
      return @emails if @emails

      @emails = Mailpeek.emails

      if params[:q].present?
        @emails = @emails.select { |x| x.match?(params[:q]) }
      end

      @total_count = emails.size
      @emails = @emails.first((params[:per] || 20).to_i)
    end

    def unread
      @unread ||= Mailpeek.unread
    end

    def root_path
      "#{env['SCRIPT_NAME']}/"
    end

    def product_version
      "v#{Mailpeek::VERSION}"
    end

    def query_string
      @query_string ||= request.query_string
    end

    def h(text)
      ::Rack::Utils.escape_html(text)
    rescue ArgumentError => e
      raise unless e.message.eql?('invalid byte sequence in UTF-8')

      text.encode!('UTF-16', 'UTF-8', invalid: :replace, replace: '')
          .encode!('UTF-8', 'UTF-16')
      retry
    end

    def simple_format(text)
      text.split("\n").join('<br />')
    end

    def redirect_with_query(url)
      redirect("#{url}?#{query_string}")
    end
  end
end
