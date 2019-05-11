# frozen_string_literal: true
require 'uri'
require 'set'
require 'yaml'
require 'cgi'

module Mailpeek
  # This is not a public API
  module WebHelpers
    def poll_path
      if current_path != '' && params['poll']
        root_path + current_path
      else
        ""
      end
    end

    # mperham/sidekiq#3243
    def unfiltered?
      yield unless env['PATH_INFO'].start_with?("/filter/")
    end

    def emails
      return @emails if @emails

      @emails = Mailpeek.emails

      if params['q'].present?
        @emails = @emails.select { |x| x.match?(params['q']) }
      end

      @total_count = @emails.size
      @emails = @emails.first(params['q'] || 10)
    end

    def unread
      @unread ||= Mailpeek.unread
    end

    def root_path
      "#{env['SCRIPT_NAME']}/"
    end

    def current_path
      @current_path ||= request.path_info.gsub(/^\//,'')
    end

    def relative_time(time)
      stamp = time.getutc.iso8601
      %{<time class="ltr" dir="ltr" title="#{stamp}" datetime="#{stamp}">#{time}</time>}
    end

    def parse_params(params)
      score, jid = params.split("-", 2)
      [score.to_f, jid]
    end

    def truncate(text, truncate_after_chars = 2000)
      truncate_after_chars && text.size > truncate_after_chars ? "#{text[0..truncate_after_chars]}..." : text
    end

    def h(text)
      sanitized = ::Rack::Utils.escape_html(text)
    rescue ArgumentError => e
      raise unless e.message.eql?('invalid byte sequence in UTF-8')
      text.encode!('UTF-16', 'UTF-8', invalid: :replace, replace: '').encode!('UTF-8', 'UTF-16')
      retry
    end

    def simple_format(text)
      paragraphs = split_paragraphs(text)

      return text if paragraphs.empty?

      paragraphs.map! do |paragraph|
        "<p>#{paragraph}</p>"
      end.join("\n\n")
    end

    def split_paragraphs(text)
      return [] if text.blank?

      text.to_str.gsub(/\r\n?/, "\n").split(/\n\n+/).map! do |t|
        t.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') || t
      end
    end

    # Any paginated list that performs an action needs to redirect
    # back to the proper page after performing that action.
    def redirect_with_query(url)
      r = request.referer
      if r && r =~ /\?/
        ref = URI(r)
        redirect("#{url}?#{ref.query}")
      else
        redirect url
      end
    end

    def environment_title_prefix
      environment = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

      "[#{environment.upcase}] " unless environment == "production"
    end

    def product_version
      "Mailpeek v#{Mailpeek::VERSION}"
    end

    def server_utc_time
      Time.now.utc.strftime('%H:%M:%S UTC')
    end
  end
end
